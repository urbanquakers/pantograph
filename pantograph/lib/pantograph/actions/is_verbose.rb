module Pantograph
  module Actions
    module SharedValues
      IS_VERBOSE = :IS_VERBOSE
    end

    class IsVerboseAction < Action
      def self.run(params)
        Actions.lane_context[:IS_VERBOSE] = PantographCore::Globals.verbose? ? true : false
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'Returns Boolean whether `--verbose` flag was set'
      end

      def self.details
        ''
      end

      def self.available_options
        []
      end

      def self.output
        [
          ['IS_VERBOSE', 'Boolean whether verbosity flag was set']
        ]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.authors
        # So no one will ever forget your contribution to pantograph :) You are awesome btw!
        ['johnknapprs']
      end

      def self.is_supported?(platform)
        true
      end

      # Is printed out in the Steps: output in the terminal
      # Return nil if you don't want any logging in the terminal/JUnit Report
      def self.step_text
        self.action_name
      end

      # Returns an array of string of sample usage of this action
      def self.example_code
        [
          'if is_verbose?
             UI.important("Verbosity is turned on!")
           else
             UI.message("Verbosity is turned off!")
           end
          '

        ]
      end

      def category
        # Available Categories: ./pantograph/lib/pantograph/action.rb
        :misc
      end

      # If category == :deprecated, uncomment to include a message for user
      # def self.deprecated_notes
      #   nil
      # end
    end
  end
end
