module Pantograph
  module Actions
    class GitSubmoduleUpdateAction < Action
      def self.run(params)
        cmd = []
        cmd << 'git submodule update'
        cmd << '--init'      if params[:init]
        cmd << '--recursive' if params[:recursive]
        cmd = cmd.join(' ')

        Actions.sh(cmd)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'Execute git submodule command'
      end

      def self.available_options
        [
          PantographCore::ConfigItem.new(
            key: :recursive,
            description: 'Add the `--recursive` flag',
            type: Boolean,
            default_value: false
          ),
          PantographCore::ConfigItem.new(
            key: :init,
            description: 'Add the `--init` flag',
            type: Boolean,
            is_string: false,
            default_value: false
          )
        ]
      end

      def self.output
      end

      def self.return_value
      end

      def self.authors
        ['johnknapprs']
      end

      def self.is_supported?(platform)
        true
      end

      def self.category
        :source_control
      end
    end
  end
end
