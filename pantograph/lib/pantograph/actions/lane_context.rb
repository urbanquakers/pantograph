module Pantograph
  module Actions
    class LaneContextAction < Action
      def self.run(params)
        Actions.lane_context
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'Access lane context values'
      end

      def self.details
        [
          'More information about how the lane context works:',
          '[https://johnknapprs.github.io/pantograph/advanced/#lane-context](https://johnknapprs.github.io/pantograph/advanced/#lane-context)'
        ].join(' ')
      end

      def self.available_options
        []
      end

      def self.output
        []
      end

      def self.return_type
        :hash
      end

      def self.authors
        ['KrauseFx']
      end

      def self.is_supported?(platform)
        true
      end

      # We don't want to show this as step
      def self.step_text
        nil
      end

      def self.example_code
        [
          'lane_context[:BUILD_NUMBER]',
          'lane_context[SharedValues::NUMBER_OF_COMMITS]'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
