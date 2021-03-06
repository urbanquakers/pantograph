module Pantograph
  module Actions
    class GitPullAction < Action
      def self.run(params)
        Actions.sh('git pull')
      end

      def self.description
        'Executes a simple git pull command'
      end

      def self.available_options
      end

      def self.authors
        ['johnknapprs']
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'git_pull'
        ]
      end

      def self.category
        :source_control
      end
    end
  end
end
