module Pantograph
  module Actions
    class GitPullTagsAction < Action
      def self.run(params)
        Actions.sh('git fetch --tags')
      end

      def self.description
        'Executes a simple `git fetch --tags` command'
      end

      def self.authors
        ['johnknapprs']
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'git_pull_tags'
        ]
      end

      def self.category
        :source_control
      end
    end
  end
end
