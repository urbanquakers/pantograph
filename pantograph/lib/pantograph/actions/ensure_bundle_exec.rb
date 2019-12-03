module Pantograph
  module Actions
    module SharedValues
    end

    # Raises an exception and stop the lane execution if not using bundle exec to run pantograph
    class EnsureBundleExecAction < Action
      def self.run(params)
        return if PluginManager.new.gemfile_path.nil?
        if PantographCore::Helper.bundler?
          UI.success("Using bundled pantograph ✅")
        else
          UI.user_error!("pantograph detected a Gemfile in the current directory. However it seems like you don't use `bundle exec`. Use `bundle exec pantograph #{ARGV.join(' ')}`")
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Raises an exception if not using `bundle exec` to run pantograph"
      end

      def self.details
        [
          "This action will check if you are using bundle exec to run pantograph.",
          "You can put it into `before_all` and make sure that pantograph is run using `bundle exec pantograph` command."
        ].join("\n")
      end

      def self.available_options
        []
      end

      def self.output
        []
      end

      def self.author
        ['rishabhtayal']
      end

      def self.example_code
        [
          "ensure_bundle_exec"
        ]
      end

      def self.category
        :misc
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
