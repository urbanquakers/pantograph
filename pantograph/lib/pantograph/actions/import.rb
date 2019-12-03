module Pantograph
  module Actions
    class ImportAction < Action
      def self.run(params)
        # this is implemented in the pant_file.rb
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Import another Pantfile to use its lanes"
      end

      def self.details
        [
          "This is useful if you have shared lanes across multiple apps and you want to store a Pantfile in a separate folder.",
          "The path must be relative to the Pantfile this is called from."
        ].join("\n")
      end

      def self.available_options
      end

      def self.output
        []
      end

      def self.authors
        ["KrauseFx"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'import("./path/to/other/Pantfile")'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
