require "pantograph/cli_tools_distributor"

module Pantograph
  class PluginManager
    require "bundler"

    PLUGINFILE_NAME = "Pluginfile".freeze
    DEFAULT_GEMFILE_PATH = "Gemfile".freeze
    AUTOGENERATED_LINE = "# Autogenerated by pantograph\n#\n# Ensure this file is checked in to source control!\n\n"
    GEMFILE_SOURCE_LINE = "source \"https://rubygems.org\"\n"
    PANTOGRAPH_PLUGIN_PREFIX = "pantograph-plugin-"
    TROUBLESHOOTING_URL = "https://urbanquakers.github.io/pantograph/plugins/plugins-troubleshooting/"

    #####################################################
    # @!group Reading the files and their paths
    #####################################################

    def gemfile_path
      # This is pretty important, since we don't know what kind of
      # Gemfile the user has (e.g. Gemfile, gems.rb, or custom env variable)
      Bundler::SharedHelpers.default_gemfile.to_s
    rescue Bundler::GemfileNotFound
      nil
    end

    def pluginfile_path
      if PantographCore::PantographFolder.path
        return File.join(PantographCore::PantographFolder.path, PLUGINFILE_NAME)
      else
        return nil
      end
    end

    def gemfile_content
      File.read(gemfile_path) if gemfile_path && File.exist?(gemfile_path)
    end

    def pluginfile_content
      File.read(pluginfile_path) if pluginfile_path && File.exist?(pluginfile_path)
    end

    #####################################################
    # @!group Helpers
    #####################################################

    def self.plugin_prefix
      PANTOGRAPH_PLUGIN_PREFIX
    end

    def self.to_gem_name(plugin_name)
      plugin_name.start_with?(plugin_prefix) ? plugin_name : (plugin_prefix + plugin_name)
    end

    # Returns an array of gems that are added to the Gemfile or Pluginfile
    def available_gems
      return [] unless gemfile_path
      dsl = Bundler::Dsl.evaluate(gemfile_path, nil, true)
      return dsl.dependencies.map(&:name)
    end

    # Returns an array of pantograph plugins that are added to the Gemfile or Pluginfile
    # The returned array contains the string with their prefixes (e.g. pantograph-plugin-xcversion)
    def available_plugins
      available_gems.keep_if do |current|
        current.start_with?(self.class.plugin_prefix)
      end
    end

    # Check if a plugin is added as dependency to either the
    # Gemfile or the Pluginfile
    def plugin_is_added_as_dependency?(plugin_name)
      UI.user_error!("pantograph plugins must start with '#{self.class.plugin_prefix}' string") unless plugin_name.start_with?(self.class.plugin_prefix)
      return available_plugins.include?(plugin_name)
    end

    #####################################################
    # @!group Modifying dependencies
    #####################################################

    def add_dependency(plugin_name)
      UI.user_error!("pantograph is not setup for this project, make sure you have a pantograph folder") unless pluginfile_path
      plugin_name = self.class.plugin_prefix + plugin_name unless plugin_name.start_with?(self.class.plugin_prefix)

      if plugin_name.gsub(self.class.plugin_prefix, '').include?("-")
        # e.g. "pantograph-plugin-ya_tu-sabes" (which is invalid)
        UI.user_error!("Plugin name must not contain a '-', did you mean '_'?")
      end

      unless plugin_is_added_as_dependency?(plugin_name)
        content = pluginfile_content || AUTOGENERATED_LINE

        unless content.end_with?("\n")
          content += "\n"
        end

        line_to_add = "gem '#{plugin_name}'"
        line_to_add += gem_dependency_suffix(plugin_name)
        UI.verbose("Adding line: #{line_to_add}")

        content += "#{line_to_add}\n"
        File.write(pluginfile_path, content)
        UI.success("Plugin '#{plugin_name}' was added to '#{pluginfile_path}'")
      end

      # We do this *after* creating the Plugin file
      # Since `bundle exec` would be broken if something fails on the way
      ensure_plugins_attached!

      true
    end

    # Get a suffix (e.g. `path` or `git` for the gem dependency)
    def gem_dependency_suffix(plugin_name)
      return "" unless self.class.fetch_gem_info_from_rubygems(plugin_name).nil?

      selection_git_url = "Git URL"
      selection_path = "Local Path"
      selection_rubygems = "RubyGems.org ('#{plugin_name}' seems to not be available there)"
      selection_gem_server = "Other Gem Server"
      selection = UI.select(
        "Seems like the plugin is not available on RubyGems, what do you want to do?",
        [selection_git_url, selection_path, selection_rubygems, selection_gem_server]
      )

      if selection == selection_git_url
        git_url = UI.input('Please enter the URL to the plugin, including the protocol (e.g. https:// or git://)')
        return ", git: '#{git_url}'"
      elsif selection == selection_path
        path = UI.input('Please enter the relative path to the plugin you want to use. It has to point to the directory containing the .gemspec file')
        return ", path: '#{path}'"
      elsif selection == selection_rubygems
        return ""
      elsif selection == selection_gem_server
        source_url = UI.input('Please enter the gem source URL which hosts the plugin you want to use, including the protocol (e.g. https:// or git://)')
        return ", source: '#{source_url}'"
      else
        UI.user_error!("Unknown input #{selection}")
      end
    end

    # Modify the user's Gemfile to load the plugins
    def attach_plugins_to_gemfile!(path_to_gemfile)
      content = gemfile_content || (AUTOGENERATED_LINE + GEMFILE_SOURCE_LINE)

      # We have to make sure pantograph is also added to the Gemfile, since we now use
      # bundler to run pantograph
      content += "\ngem 'pantograph'\n" unless available_gems.include?('pantograph')
      content += "\n#{self.class.code_to_attach}\n"

      File.write(path_to_gemfile, content)
    end

    #####################################################
    # @!group Accessing RubyGems
    #####################################################

    def self.fetch_gem_info_from_rubygems(gem_name)
      require 'open-uri'
      require 'json'
      url = "https://rubygems.org/api/v1/gems/#{gem_name}.json"
      begin
        JSON.parse(open(url).read)
      rescue
        nil
      end
    end

    #####################################################
    # @!group Installing and updating dependencies
    #####################################################

    # Warning: This will exec out
    # This is necessary since the user might be prompted for their password
    def install_dependencies!
      # Using puts instead of `UI` to have the same style as the `echo`
      puts("Installing plugin dependencies...")
      ensure_plugins_attached!
      with_clean_bundler_env do
        cmd = "bundle install"
        cmd << " --quiet" unless PantographCore::Globals.verbose?
        cmd << " && echo 'Successfully installed plugins'"
        UI.command(cmd) if PantographCore::Globals.verbose?
        exec(cmd)
      end
    end

    # Warning: This will exec out
    # This is necessary since the user might be prompted for their password
    def update_dependencies!
      puts("Updating plugin dependencies...")
      ensure_plugins_attached!
      plugins = available_plugins
      if plugins.empty?
        UI.user_error!("No plugins are installed")
      end
      with_clean_bundler_env do
        cmd = "bundle update"
        cmd << " #{plugins.join(' ')}"
        cmd << " --quiet" unless PantographCore::Globals.verbose?
        cmd << " && echo 'Successfully updated plugins'"
        UI.command(cmd) if PantographCore::Globals.verbose?
        exec(cmd)
      end
    end

    def with_clean_bundler_env
      # There is an interesting problem with using exec to call back into Bundler
      # The `bundle ________` command that we exec, inherits all of the Bundler
      # state we'd already built up during this run. That was causing the command
      # to fail, telling us to install the Gem we'd just introduced, even though
      # that is exactly what we are trying to do!
      #
      # Bundler.with_clean_env solves this problem by resetting Bundler state before the
      # exec'd call gets merged into this process.

      Bundler.with_clean_env do
        yield if block_given?
      end
    end

    #####################################################
    # @!group Initial setup
    #####################################################

    def setup
      UI.important("It looks like pantograph plugins are not yet set up for this project.")

      path_to_gemfile = gemfile_path || DEFAULT_GEMFILE_PATH

      if gemfile_content.to_s.length > 0
        UI.important("pantograph will modify your existing Gemfile at path '#{path_to_gemfile}'")
      else
        UI.important("pantograph will create a new Gemfile at path '#{path_to_gemfile}'")
      end

      UI.important("This change is necessary for pantograph plugins to work")

      unless UI.confirm("Should pantograph modify the Gemfile at path '#{path_to_gemfile}' for you?")
        UI.important("Please add the following code to '#{path_to_gemfile}':")
        puts("")
        puts(self.class.code_to_attach.magenta) # we use `puts` instead of `UI` to make it easier to copy and paste
        UI.user_error!("Please update '#{path_to_gemfile} and run pantograph again")
      end

      attach_plugins_to_gemfile!(path_to_gemfile)
      UI.success("Successfully modified '#{path_to_gemfile}'")
    end

    # The code required to load the Plugins file
    def self.code_to_attach
      if PantographCore::PantographFolder.path
        pantograph_folder_name = File.basename(PantographCore::PantographFolder.path)
      else
        pantograph_folder_name = "pantograph"
      end
      "plugins_path = File.join(File.dirname(__FILE__), '#{pantograph_folder_name}', '#{PluginManager::PLUGINFILE_NAME}')\n" \
      "eval_gemfile(plugins_path) if File.exist?(plugins_path)"
    end

    # Makes sure, the user's Gemfile actually loads the Plugins file
    def plugins_attached?
      gemfile_path && gemfile_content.include?(PluginManager::PLUGINFILE_NAME)
    end

    def ensure_plugins_attached!
      return if plugins_attached?
      self.setup
    end

    #####################################################
    # @!group Requiring the plugins
    #####################################################

    # Iterate over all available plugins
    # which follow the naming convention
    #   pantograph-plugin-[plugin_name]
    # This will make sure to load the action
    # and all its helpers
    def load_plugins
      UI.verbose("Checking if there are any plugins that should be loaded...")

      loaded_plugins = false
      available_plugins.each do |gem_name|
        UI.verbose("Loading '#{gem_name}' plugin")
        begin
          # BEFORE requiring the gem, we get a list of loaded actions
          # This way we can check inside `store_plugin_reference` if
          # any actions were overwritten
          self.loaded_pantograph_actions.concat(Pantograph::Actions.constants)

          PantographRequire.install_gem_if_needed(gem_name: gem_name, require_gem: true)

          store_plugin_reference(gem_name)
          loaded_plugins = true
        rescue StandardError, ScriptError => ex # some errors, like ScriptError are not caught unless explicitly
          UI.error("Error loading plugin '#{gem_name}': #{ex}")

          # We'll still add it to the table, to make the error
          # much more visible and obvious
          self.plugin_references[gem_name] = {
            version_number: Pantograph::ActionCollector.determine_version(gem_name),
            actions: []
          }
        end
      end

      if !loaded_plugins && self.pluginfile_content.to_s.include?(PluginManager.plugin_prefix)
        UI.error("It seems like you wanted to load some plugins, however they couldn't be loaded")
        UI.error("Please follow the troubleshooting guide: #{TROUBLESHOOTING_URL}")
      end

      skip_print_plugin_info = self.plugin_references.empty? || CLIToolsDistributor.running_version_command? || PantographCore::Env.truthy?("PANTOGRAPH_ENV_PRINTER")

      # We want to avoid printing output other than the version number if we are running `pantograph -v`
      print_plugin_information(self.plugin_references) unless skip_print_plugin_info
    end

    # Prints a table all the plugins that were loaded
    def print_plugin_information(references)
      rows = references.collect do |current|
        if current[1][:actions].empty?
          # Something is wrong with this plugin, no available actions
          [current[0].red, current[1][:version_number], "No actions found".red]
        else
          [current[0], current[1][:version_number], current[1][:actions].join("\n")]
        end
      end

      require 'terminal-table'
      puts(Terminal::Table.new({
        rows: PantographCore::PrintTable.transform_output(rows),
        title: "Used plugins".green,
        headings: ["Plugin", "Version", "Action"]
      }))
      puts("")
    end

    #####################################################
    # @!group Reference between plugins to actions
    #####################################################

    # Connection between plugins and their actions
    # Example value of plugin_references
    # => {"pantograph-plugin-ruby" => {
    #          version_number: "0.1.0",
    #          actions: [:rspec, :rubocop]
    #     }}
    def plugin_references
      @plugin_references ||= {}
    end

    # Contains an array of symbols for the action classes
    def loaded_pantograph_actions
      @pantograph_actions ||= []
    end

    def store_plugin_reference(gem_name)
      module_name = gem_name.gsub(PluginManager.plugin_prefix, '').pantograph_class
      # We store a collection of the imported plugins
      # This way we can tell which action came from what plugin
      # (a plugin may contain any number of actions)
      version_number = Pantograph::ActionCollector.determine_version(gem_name)
      references = Pantograph.const_get(module_name).all_classes.collect do |path|
        next unless File.dirname(path).end_with?("/actions") # we only want to match actions

        File.basename(path).gsub("_action", "").gsub(".rb", "").to_sym # the _action is optional
      end
      references.compact!

      # Check if this overwrites a built-in action and
      # show a warning if that's the case
      references.each do |current_ref|
        # current_ref is a symbol, e.g. :emoji_fetcher
        class_name = (current_ref.to_s.pantograph_class + 'Action').to_sym

        if self.loaded_pantograph_actions.include?(class_name)
          UI.important("Plugin '#{module_name}' overwrites already loaded action '#{current_ref}'")
        end
      end

      self.plugin_references[gem_name] = {
        version_number: version_number,
        actions: references
      }
    end
  end
end
