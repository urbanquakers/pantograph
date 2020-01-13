module Pantograph
  module Actions
    class EnsureEnvVarsAction < Action
      def self.run(params)
        null_keys = params[:vars].reject do |var|
          ENV.key?(var)
        end

        if null_keys.any?
          UI.user_error!("Unable to find ENV Variable(s):\n#{null_keys.join("\n")}")
        end

        UI.success("ENV variable(s) '#{params[:vars].join('\', \'')}' set!")
      end

      def self.description
        'Raises an exception if the specified env vars are not set'
      end

      def self.details
      end

      def self.available_options
        [
          PantographCore::ConfigItem.new(
            key: :vars,
            description: 'The ENV variables keys to verify',
            type: Array,
            verify_block: proc do |value|
              UI.user_error!('Specify at least one environment variable key') if value.empty?
            end
          )
        ]
      end

      def self.authors
        ['johnknapprs']
      end

      def self.example_code
        [
          'ensure_env_vars(
            vars: [\'GITHUB_USER_NAME\', \'GITHUB_API_TOKEN\']
          )'
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
