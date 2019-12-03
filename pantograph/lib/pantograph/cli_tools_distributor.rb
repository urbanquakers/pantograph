module Pantograph
  # This class is responsible for checking the ARGV
  # to see if the user wants to launch another pantograph
  # tool or pantograph itself
  class CLIToolsDistributor
    class << self
      def running_version_command?
        ARGV.include?('-v') || ARGV.include?('--version')
      end

      def running_help_command?
        ARGV.include?('-h') || ARGV.include?('--help')
      end

      def running_init_command?
        ARGV.include?("init")
      end

      def utf8_locale?
        (ENV['LANG'] || "").end_with?("UTF-8", "utf8") || (ENV['LC_ALL'] || "").end_with?("UTF-8", "utf8") || (PantographCore::CommandExecutor.which('locale') && `locale charmap`.strip == "UTF-8")
      end

      def take_off
        before_import_time = Time.now

        if !ENV["PANTOGRAPH_DISABLE_ANIMATION"]
          # Usually in the pantograph code base we use
          #
          #   Helper.show_loading_indicator
          #   longer_taking_task_here
          #   Helper.hide_loading_indicator
          #
          # but in this case we haven't required PantographCore yet
          # so we'll have to access the raw API for now
          require "tty-spinner"
          require_pantograph_spinner = TTY::Spinner.new("[:spinner] 🚀 ", format: :dots)
          require_pantograph_spinner.auto_spin

          # this might take a long time if there is no Gemfile :(
          # That's why we show the loading indicator here also
          require "pantograph"

          require_pantograph_spinner.success
        else
          require "pantograph"
        end
        # We want to avoid printing output other than the version number if we are running `pantograph -v`
        unless running_version_command? || running_init_command?
          print_bundle_exec_warning(is_slow: (Time.now - before_import_time > 3))
        end

        # Try to check UTF-8 with `locale`, fallback to environment variables
        unless utf8_locale?
          warn = "WARNING: pantograph requires your locale to be set to UTF-8. To learn more go to https://johnknapprs.github.io/pantograph/getting-started/ios/setup/#set-up-environment-variables"
          UI.error(warn)
          at_exit do
            # Repeat warning here so users hopefully see it
            UI.error(warn)
          end
        end

        # Loading any .env files before any lanes are called since
        # variables like PANTOGRAPH_HIDE_CHANGELOG and PANTOGRAPH_DISABLE_COLORS
        # need to be set early on in execution
        require 'pantograph/helper/dotenv_helper'
        Pantograph::Helper::DotenvHelper.load_dot_env(nil)

        # Needs to go after load_dot_env for variable PANTOGRAPH_SKIP_UPDATE_CHECK
        PantographCore::UpdateChecker.start_looking_for_update('pantograph')

        # Disabling colors if environment variable set
        require 'pantograph_core/ui/disable_colors' if PantographCore::Helper.colors_disabled?

        tool_name = ARGV.first ? ARGV.first.downcase : nil

        tool_name = process_emojis(tool_name)

        if tool_name && Pantograph::TOOLS.include?(tool_name.to_sym) && !available_lanes.include?(tool_name.to_sym)
          # Triggering a specific tool
          # This happens when the users uses things like
          #
          #   pantograph sigh
          #
          require tool_name
          begin
            # First, remove the tool's name from the arguments
            # Since it will be parsed by the `commander` at a later point
            # and it must not contain the binary name
            ARGV.shift

            # Import the CommandsGenerator class, which is used to parse
            # the user input
            require File.join(tool_name, "commands_generator")

            # Call the tool's CommandsGenerator class and let it do its thing
            commands_generator = Object.const_get(tool_name.pantograph_module)::CommandsGenerator
          rescue LoadError
            # This will only happen if the tool we call here, doesn't provide
            # a CommandsGenerator class yet
            # When we launch this feature, this should never be the case
            abort("#{tool_name} can't be called via `pantograph #{tool_name}`, run '#{tool_name}' directly instead".red)
          end

          # Some of the tools use other actions so need to load all
          # actions before we start the tool generator
          # Example: scan uses slack
          Pantograph.load_actions

          commands_generator.start
        # elsif tool_name == "pantograph-credentials"
        #   require 'credentials_manager'
        #   ARGV.shift
        #   CredentialsManager::CLI.new.run
        else
          # Triggering pantograph to call a lane
          require "pantograph/commands_generator"
          Pantograph::CommandsGenerator.start
        end
      ensure
        PantographCore::UpdateChecker.show_update_status('pantograph', Pantograph::VERSION)
      end

      # Since pantograph also supports the rocket and biceps emoji as executable
      # we need to map those to the appropriate tools
      def process_emojis(tool_name)
        return {
          "🚀" => "pantograph",
          "💪" => "gym"
        }[tool_name] || tool_name
      end

      def print_bundle_exec_warning(is_slow: false)
        return if PantographCore::Helper.bundler? # user is alread using bundler
        return if PantographCore::Env.truthy?('SKIP_SLOW_PANTOGRAPH_WARNING') # user disabled the warnings
        return if PantographCore::Helper.contained_pantograph? # user uses the bundled pantograph

        gemfile_path = PluginManager.new.gemfile_path
        if gemfile_path
          # The user has a Gemfile, but forgot to use `bundle exec`
          # Let's tell the user how to use `bundle exec`
          # We show this warning no matter if the command is slow or not
          UI.important("pantograph detected a Gemfile in the current directory")
          UI.important("however it seems like you don't use `bundle exec`")
          UI.important("to launch pantograph faster, please use")
          UI.message("")
          UI.command "bundle exec pantograph #{ARGV.join(' ')}"
          UI.message("")
        elsif is_slow
          # pantograph is slow and there is no Gemfile
          # Let's tell the user how to use `gem cleanup` and how to
          # start using a Gemfile
          UI.important('Seems like launching pantograph takes a while - please run')
          UI.message('')
          UI.command('gem cleanup')
          UI.message('')
          UI.important('to uninstall outdated gems and make pantograph launch faster')
          UI.important('Alternatively it is recommended to start using a Gemfile to lock your dependencies')
          UI.important('To get started with a Gemfile, run')
          UI.message('')
          UI.command 'bundle init'
          UI.command "echo 'gem \"pantograph\"' >> Gemfile"
          UI.command 'bundle install'
          UI.message('')
          UI.important('After creating the Gemfile and Gemfile.lock, commit those files into version control')
        end
        UI.important('Get started using a Gemfile for pantograph https://johnknapprs.github.io/pantograph/getting-started/ios/setup/#use-a-gemfile')
      end

      # Returns an array of symbols for the available lanes for the Pantfile
      # This doesn't actually use the Pantfile parser, but only
      # the available lanes. This way it's much faster, which
      # is very important in this case, since it will be executed
      # every time one of the tools is launched
      # Use this only if performance is :key:
      def available_lanes
        pantfile_path = PantographCore::PantographFolder.pantfile_path
        return [] if pantfile_path.nil?
        output = `cat #{pantfile_path.shellescape} | grep \"^\s*lane \:\" | awk -F ':' '{print $2}' | awk -F ' ' '{print $1}'`
        return output.strip.split(" ").collect(&:to_sym)
      end
    end
  end
end
