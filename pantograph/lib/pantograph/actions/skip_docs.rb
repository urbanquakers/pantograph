module Pantograph
  module Actions
    class SkipDocsAction < Action
      def self.run(params)
        ENV["PANTOGRAPH_SKIP_DOCS"] = "1"
      end

      def self.step_text
        nil
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Skip the creation of the pantograph/README.md file when running pantograph"
      end

      def self.available_options
      end

      def self.output
      end

      def self.return_value
      end

      def self.details
        "Tell _pantograph_ to not automatically create a `pantograph/README.md` when running _pantograph_. You can always trigger the creation of this file manually by running `pantograph docs`."
      end

      def self.authors
        ["KrauseFx"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'skip_docs'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
