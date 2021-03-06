module Pantograph
  module Actions
    class OptOutUsageAction < Action
      def self.run(params)
        ENV['PANTOGRAPH_OPT_OUT_USAGE'] = 'YES'
        UI.message('Disabled upload of used actions')
      end

      def self.description
        'This will stop uploading the information which actions were run'
      end

      def self.details
        [
          'By default, _pantograph_ will track what actions are being used. No personal/sensitive information is recorded.',
          'Learn more at [https://urbanquakers.github.io/pantograph/#metrics](https://urbanquakers.github.io/pantograph/#metrics).',
          'Add `opt_out_usage` at the top of your Pantfile to disable metrics collection.'
        ].join("\n")
      end

      def self.authors
        ['KrauseFx']
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          ' # add this to the top of your Pantfile
            opt_out_usage
          '
        ]
      end

      def self.step_text
        'Disabled Usage Data Tracking'
      end

      def self.category
        :misc
      end
    end
  end
end
