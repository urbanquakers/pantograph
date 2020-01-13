module Pantograph
  module Actions
    module SharedValues
      GIT_BRANCH_NAME = :GIT_BRANCH_NAME
    end

    class GitBranchAction < Action
      def self.run(params)
        Actions.lane_context[SharedValues::GIT_BRANCH_NAME] = Helper::Git.current_branch
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'Returns the name of the current git branch'
      end

      def self.details
        'If no branch could be found, this action will return an empty string'
      end

      def self.available_options
        []
      end

      def self.output
        [
          ['GIT_BRANCH_NAME', 'The git branch name']
        ]
      end

      def self.authors
        ['johnknapprs']
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'git_branch'
        ]
      end

      def self.return_type
        :string
      end

      def self.category
        :source_control
      end
    end
  end
end
