module Pantograph
  class MarkdownDocsGenerator
    attr_accessor :categories

    def initialize
      require 'pantograph'
      require 'pantograph/documentation/actions_list'
      Pantograph.load_actions

      self.work
    end

    def work
      fill_built_in_actions
    end

    def fill_built_in_actions
      self.categories = {}

      Pantograph::Action::AVAILABLE_CATEGORIES.each { |a| self.categories[readable_category_name(a)] = {} }

      # Fill categories with all built-in actions
      ActionsList.all_actions do |action|
        readable = readable_category_name(action.category)

        if self.categories[readable].kind_of?(Hash)
          self.categories[readable][number_of_launches_for_action(action.action_name)] = action
        else
          UI.error("Action '#{action.name}' doesn't contain category information... skipping")
        end
      end
    end

    def number_of_launches_for_action(action_name)
      found = all_actions_from_enhancer.find { |c| c['action'] == action_name.to_s }

      return found["index"] if found
      return 10_000 + rand # new actions that we've never tracked before will be shown at the bottom of the page, need `rand` to not overwrite them
    end

    def all_actions_from_enhancer
      require 'json'
      @_launches ||= JSON.parse(File.read(File.join(Pantograph::ROOT, "assets/action_ranking.json"))) # root because we're in a temporary directory here
    end

    def actions_path
      "lib/pantograph/actions/"
    end

    def where_is(klass)
      # Gets all source files for action
      methods = klass.methods(false).map { |m| klass.method(m) }
      source_files = methods
                     .map(&:source_location)
                     .compact
                     .map { |(file, line)| file }
                     .uniq

      # Return file or error if multiples
      if source_files.size == 1
        return source_files.first
      else
        UI.crash!("Multiple source files were found for action `#{klass}`")
      end
    end

    def filename_for_action(action)
      absolute_path = where_is(action)
      filename = File.basename(absolute_path)

      path = File.join(Pantograph::ROOT, actions_path, filename)
      unless File.exist?(path)
        UI.error("Action '#{action.name}' not found in root pantograph project... skipping")
        UI.verbose("Action '#{action.name}' found at #{path}")
        return nil
      end
      filename
    end

    def custom_action_docs_path
      "lib/pantograph/actions/docs/"
    end

    def load_custom_action_md(action)
      # check if there is a custom detail view in markdown available in the pantograph code base
      custom_file_location = File.join(Pantograph::ROOT, custom_action_docs_path, "#{action.action_name}.md")
      if File.exist?(custom_file_location)
        UI.verbose("Using custom md file for action #{action.action_name}")
        return File.read(custom_file_location)
      end
      return load_custom_action_md_erb(action)
    end

    def load_custom_action_md_erb(action)
      # check if there is a custom detail view as markdown ERB available in the pantograph code base
      custom_file_location = File.join(Pantograph::ROOT, custom_action_docs_path, "#{action.action_name}.md.erb")
      if File.exist?(custom_file_location)
        UI.verbose("Using custom md.erb file for action #{action.action_name}")

        result = ERB.new(File.read(custom_file_location), 0, '-').result(binding) # https://web.archive.org/web/20160430190141/www.rrn.dk/rubys-erb-templating-system

        return result
      end
      return nil
    end

    def actions_md_contents
      action_mds = {}

      ActionsList.all_actions do |action|
        @action = action
        @action_filename = filename_for_action(action)

        unless @action_filename
          next
        end

        @custom_content = load_custom_action_md(action)

        if action.superclass != Pantograph::Action
          @custom_content ||= load_custom_action_md(action.superclass)
        end

        template = File.join(Pantograph::ROOT, "lib/assets/ActionDetails.md.erb")
        result = ERB.new(File.read(template), 0, '-').result(binding)

        action_mds[action.action_name] = result
      end

      return action_mds
    end

    def generate!(target_path: nil)
      require 'yaml'
      FileUtils.mkdir_p(target_path)
      docs_dir = File.join(target_path, "docs")

      # Generate actions.md
      template = File.join(Pantograph::ROOT, "lib/assets/Actions.md.erb")
      result = ERB.new(File.read(template), 0, '-').result(binding) # https://web.archive.org/web/20160430190141/www.rrn.dk/rubys-erb-templating-system
      File.write(File.join(docs_dir, "actions.md"), result)

      # Generate actions sub pages (e.g. actions/slather.md, actions/scan.md)
      all_actions_ref_yml = []
      FileUtils.mkdir_p(File.join(docs_dir, "actions"))
      ActionsList.all_actions do |action|
        @action = action # to provide a reference in the .html.erb template
        @action_filename = filename_for_action(action)

        unless @action_filename
          next
        end

        # Make sure to always assign `@custom_content`, as we're in a loop and `@` is needed for the `erb`
        @custom_content = load_custom_action_md(action)

        if action.superclass != Pantograph::Action
          # This means, the current method is an alias
          # meaning we're gonna look if the parent class
          # has a custom md file.
          @custom_content ||= load_custom_action_md(action.superclass)
        end

        template = File.join(Pantograph::ROOT, "lib/assets/ActionDetails.md.erb")
        result = ERB.new(File.read(template), 0, '-').result(binding) # https://web.archive.org/web/20160430190141/www.rrn.dk/rubys-erb-templating-system

        file_name = File.join("actions", "#{action.action_name}.md")
        File.write(File.join(docs_dir, file_name), result)

        all_actions_ref_yml << { action.action_name => file_name }
      end

      # Modify the mkdocs.yml to list all the actions
      mkdocs_yml_path = File.join(target_path, 'mkdocs.yml')
      raise "Could not find mkdocs.yml in #{target_path}, make sure to point to the pantograph/docs repo" unless File.exist?(mkdocs_yml_path)
      mkdocs_yml = YAML.load_file(mkdocs_yml_path)
      hidden_actions_array = mkdocs_yml['nav'].find { |p| !p['Available Actions'].nil? }
      hidden_actions_array['Available Actions'] = all_actions_ref_yml
      File.write(mkdocs_yml_path, mkdocs_yml.to_yaml)

      # Copy over the assets from the `actions/docs/assets` directory
      Dir[File.join(custom_action_docs_path, "assets", "*")].each do |current_asset_path|
        UI.message("Copying asset #{current_asset_path}")
        FileUtils.cp(current_asset_path, File.join(docs_dir, "img", "actions", File.basename(current_asset_path)))
      end

      UI.success("Generated new docs on path #{target_path}")
    end

    private

    def readable_category_name(category_symbol)
      case category_symbol
      when :misc
        "Misc"
      when :source_control
        "Source Control"
      when :notifications
        "Notifications"
      when :documentation
        "Documentation"
      when :testing
        "Testing"
      when :building
        "Building"
      when :push
        "Push"
      when :project
        "Project"
      when :beta
        "Beta"
      when :production
        "Releasing your app"
      when :deprecated
        "Deprecated"
      else
        category_symbol.to_s.capitalize
      end
    end
  end
end
