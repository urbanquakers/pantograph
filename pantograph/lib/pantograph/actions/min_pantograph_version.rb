module Pantograph
  module Actions
    module SharedValues
    end

    class MinPantographVersionAction < Action
      def self.run(params)
        params = nil unless params.kind_of?(Array)
        value = (params || []).first
        defined_version = Gem::Version.new(value) if value

        UI.user_error!("Please pass minimum pantograph version as parameter to min_pantograph_version") unless defined_version

        if Gem::Version.new(Pantograph::VERSION) < defined_version
          PantographCore::UpdateChecker.show_update_message('pantograph', Pantograph::VERSION)
          error_message = "The Pantfile requires a pantograph version of >= #{defined_version}. You are on #{Pantograph::VERSION}."
          UI.user_error!(error_message)
        end

        UI.message("Your pantograph version #{Pantograph::VERSION} matches the minimum requirement of #{defined_version}  ✅")
      end

      def self.step_text
        "Verifying pantograph version"
      end

      def self.author
        "KrauseFx"
      end

      def self.description
        "Verifies the minimum pantograph version required"
      end

      def self.example_code
        [
          'min_pantograph_version("1.50.0")'
        ]
      end

      def self.details
        [
          "Add this to your `Pantfile` to require a certain version of _pantograph_.",
          "Use it if you use an action that just recently came out and you need it."
        ].join("\n")
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
