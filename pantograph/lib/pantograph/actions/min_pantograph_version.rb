module Pantograph
  module Actions
    class MinPantographVersionAction < Action
      def self.run(params)
        begin
          defined_version = Gem::Version.new(params.first)
        rescue
          UI.user_error!('Please provide minimum pantograph version')
        end

        if Gem::Version.new(Pantograph::VERSION) < defined_version
          PantographCore::UpdateChecker.show_update_message('pantograph', Pantograph::VERSION)
          error_message = "The Pantfile requires a pantograph version of >= #{defined_version}. You are on #{Pantograph::VERSION}."
          UI.user_error!(error_message)
        else
          UI.success("Your pantograph version #{Pantograph::VERSION} matches the minimum requirement of #{defined_version}  ✅")
        end
      end

      def self.description
        'Verifies the minimum pantograph version required'
      end

      def self.details
        'Add this to your `Pantfile` to require a certain version of _pantograph_.'
      end

      def self.authors
        ['KrauseFx', 'johnknapprs']
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'min_pantograph_version("0.14.0")'
        ]
      end

      def self.step_text
        'Verifying pantograph version'
      end

      def self.category
        :misc
      end
    end
  end
end
