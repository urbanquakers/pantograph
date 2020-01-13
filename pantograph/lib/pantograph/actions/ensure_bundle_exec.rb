module Pantograph
  module Actions
    # Raises an exception and stop the lane execution if not using bundle exec to run pantograph
    class EnsureBundleExecAction < Action
      def self.run(params)
        return if PluginManager.new.gemfile_path.nil?
        if PantographCore::Helper.bundler?
          UI.success('Using bundled pantograph ✅')
        else
          error_message = [
            'pantograph detected a Gemfile in the current directory.',
            'However it seems like you did not use `bundle exec`.',
            "Use `bundle exec pantograph #{ARGV.join(' ')}`"
          ]
          error_message = error_message.join(' ')

          UI.user_error!(error_message)
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'Raises an exception if not using `bundle exec` to run pantograph'
      end

      def self.details
        [
          'This action will check if you are using bundle exec to run pantograph.'
        ].join("\n")
      end

      def self.available_options
        []
      end

      def self.output
        []
      end

      def self.author
        ['rishabhtayal', 'johnknapprs']
      end

      def self.example_code
        [
          'ensure_bundle_exec',
          ' # always check before running a lane
          before_all do
            ensure_bundle_exec
          end
          '
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
