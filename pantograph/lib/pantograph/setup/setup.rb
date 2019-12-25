require "tty-spinner"

module Pantograph
  class Setup
    # :maven, :gradle, or other
    attr_accessor :platform

    # Path to the xcodeproj or xcworkspace
    attr_accessor :project_path

    # Used for :manual sometimes
    attr_accessor :preferred_setup_method

    # remember if there were multiple projects
    # if so, we set it as part of the Pantfile
    attr_accessor :had_multiple_projects_to_choose_from

    # The current content of the generated Pantfile
    attr_accessor :pantfile_content

    # This is the lane that we tell the user to run to try the new pantograph setup
    # This needs to be setup by each setup
    attr_accessor :lane_to_mention

    # Start the setup process

    def self.start
      if PantographCore::PantographFolder.setup? && !Helper.test?
        require 'pantograph/lane_list'
        Pantograph::LaneList.output(PantographCore::PantographFolder.pantfile_path)
        UI.important("------------------")
        UI.important("pantograph is already set up at path `#{PantographCore::PantographFolder.path}`, see the available lanes above")
        UI.message("")

        setup_generic = self.new
        setup_generic.add_or_update_gemfile(update_gemfile_if_needed: false)
        setup_generic.suggest_next_steps
        return
      end

      # this is used by e.g. configuration.rb to not show warnings when running produce
      ENV["PANTOGRAPH_ONBOARDING_IN_PROCESS"] = 1.to_s

      spinner = TTY::Spinner.new('[:spinner] Looking for projects in current directory...', format: :dots)
      spinner.auto_spin

      maven_projects   = Dir["**/pom.xml"]
      gradle_projects  = Dir["**/*.gradle"] + Dir["**/*.gradle.kts"]
      angular_projects = Dir['**/package.json']
      spinner.success

      PantographCore::PantographFolder.create_folder!

      if maven_projects.count > 0
        UI.message('Detected an Maven project in the current directory...')
        SetupMaven.new.setup_maven
      elsif gradle_projects.count > 0
        UI.message('Detected an Gradle project in the current directory...')
        SetupGradle.new.setup_gradle
      elsif angular_projects.count > 0
        UI.message('Detected an Angular project in the current directory...')
        SetupAngular.new.setup_angular
      else
        UI.error('Unable to determin project type')
        UI.error('Make sure to `cd` into the directory containing your application')
        if UI.confirm('Alternatively, would you like to manually setup a GENERIC pantograph config in the current directory instead?')
          SetupGeneric.new.setup_generic
        else
          UI.user_error!('Make sure to `cd` into the directory containing your project and then use `pantograph init` again')
        end
      end
    end

    def initialize(project_path: nil, had_multiple_projects_to_choose_from: nil, preferred_setup_method: nil)
      self.project_path = project_path
      self.had_multiple_projects_to_choose_from = had_multiple_projects_to_choose_from
      self.preferred_setup_method = preferred_setup_method
    end

    # Helpers
    def welcome_to_pantograph
      UI.header("Welcome to pantograph 🚀")
      UI.message("pantograph can help you with all kinds of automation")
      UI.message("We recommend automating one task first, and then gradually automating more over time")
    end

    # Append a lane to the current Pantfile template we're generating
    def append_lane(lane)
      lane.compact! # remove nil values

      new_lines = "\n\n"
      new_lines = "" unless self.pantfile_content.include?("lane :") # the first lane we don't want new lines

      self.pantfile_content.gsub!("[[LANES]]", "#{new_lines}#{lane.join("\n")}[[LANES]]")
    end

    def write_pantfile!
      # Write the Pantfile
      pantfile_file_name = "Pantfile"

      pantfile_path = File.join(PantographCore::PantographFolder.path, pantfile_file_name)
      self.pantfile_content.gsub!("[[LANES]]", "") # since we always keep it until writing out
      File.write(pantfile_path, self.pantfile_content) # remove trailing spaces before platform ends

      add_or_update_gemfile(update_gemfile_if_needed: true)

      UI.header("✅  Successfully generated pantograph configuration")
      UI.message("Generated Pantfile at path `#{pantfile_path}`")
      UI.message("Gemfile and Gemfile.lock at path `#{gemfile_path}`")

      UI.message("Please check the newly generated configuration files into git along with your project")
      UI.message("This way everyone in your team can benefit from your pantograph setup")
      continue_with_enter
    end

    def gemfile_path
      "Gemfile"
    end

    # Gemfile related code:
    def gemfile_exists?
      return File.exist?(gemfile_path)
    end

    def setup_gemfile!
      # No Gemfile yet
      gemfile_content = []
      gemfile_content << "source \"https://rubygems.org\""
      gemfile_content << ""
      gemfile_content << 'gem "pantograph"'
      gemfile_content << ""
      File.write(gemfile_path, gemfile_content.join("\n"))

      UI.message("Installing dependencies for you...")
      PantographCore::CommandExecutor.execute(
        command: "bundle update",
        print_all: PantographCore::Globals.verbose?,
        print_command: true,
        error: proc do |error_output|
          UI.error("Something went wrong when running `bundle update` for you")
          UI.error("Please take a look at your Gemfile at path `#{gemfile_path}`")
          UI.error("and make sure you can run `bundle update` on your machine.")
        end
      )
    end

    def ensure_gemfile_valid!(update_gemfile_if_needed: false)
      gemfile_content = File.read(gemfile_path)
      unless gemfile_content.include?("https://rubygems.org")
        UI.error("You have a local Gemfile, but RubyGems isn't defined as source")
        UI.error("Please update your Gemfile at path `#{gemfile_path}` to include")
        UI.important("")
        UI.important("source \"https://rubygems.org\"")
        UI.important("")
        UI.error("Update your Gemfile, and run `bundle update` afterwards")
      end

      unless gemfile_content.include?("pantograph")
        if update_gemfile_if_needed
          gemfile_content << "\n\ngem \"pantograph\""
          UI.message("Adding `pantograph` to your existing Gemfile at path '#{gemfile_path}'")

          File.write(gemfile_path, gemfile_content)
        else
          UI.error("You have a local Gemfile, but it doesn't include \"pantograph\" as a dependency")
          UI.error("Please add `gem \"pantograph\"` to your Gemfile")
        end
      end
    end

    # This method is responsible for ensuring there is a working
    # Gemfile, and that `pantograph` is defined as a dependency
    # while also having `rubygems` as a gem source
    def add_or_update_gemfile(update_gemfile_if_needed: false)
      if gemfile_exists?
        ensure_gemfile_valid!(update_gemfile_if_needed: update_gemfile_if_needed)
      else
        if update_gemfile_if_needed || UI.confirm("It is recommended to run pantograph with a Gemfile set up, do you want pantograph to create one for you?")
          setup_gemfile!
        end
      end
      return gemfile_path
    end

    def finish_up
      write_pantfile!
      show_analytics_note
      explain_concepts
      suggest_next_steps
    end

    def pantfile_template_content
      path = "#{Pantograph::ROOT}/lib/assets/DefaultPantfileTemplate"
      return File.read(path)
    end

    def explain_concepts
      UI.header("pantograph lanes")
      UI.message("pantograph uses a " + "`Pantfile`".yellow + " to store the automation configuration")
      UI.message("Within that, you'll see different " + "lanes".yellow + ".")
      UI.message("Each is there to automate a different task, like testing, building, or pushing new releases")
      continue_with_enter

      UI.header("How to customize your Pantfile")
      UI.message("Use a text editor of your choice to open the newly created Pantfile and take a look")
      UI.message("You can now edit the available lanes and actions to customize the setup to fit your needs")
      UI.message("To get a list of all the available actions, open " + "https://johnknapprs.github.io/pantograph/".cyan)
      continue_with_enter
    end

    def continue_with_enter
      UI.input("Continue by pressing Enter ⏎")
    end

    def suggest_next_steps
      UI.header("Where to go from here?")
      UI.message("📸  Learn more about Pantograph Official Actions")
      UI.message("\t\thttps://johnknapprs.github.io/pantograph/actions/".cyan)
      UI.message("👩‍✈️  Learn more about Pantograph Lane Features")
      UI.message("\t\thttps://johnknapprs.github.io/pantograph/advanced/lanes/".cyan)
      UI.message("🚀  Check out the entire documentation site for Pantograph")
      UI.message("\t\thttps://johnknapprs.github.io/pantograph/".cyan)

      # we crash here, so that this never happens when a new setup method is added
      return if self.lane_to_mention.to_s.length == 0
      UI.message("")
      UI.message("To try your new pantograph setup, just enter and run")
      UI.command("pantograph #{self.lane_to_mention}")
    end

    def show_analytics_note
      UI.message("pantograph will collect the number of errors for each action to detect integration issues")
      UI.message("No sensitive/private information will be uploaded, more information: " + "https://johnknapprs.github.io/pantograph/#metrics".cyan)
    end
  end
end

require 'pantograph/setup/setup_generic'
require 'pantograph/setup/setup_gradle'
require 'pantograph/setup/setup_maven'
require 'pantograph/setup/setup_angular'
