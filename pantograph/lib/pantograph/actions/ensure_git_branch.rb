module Pantograph
  module Actions
    # Raises an exception and stop the lane execution if the repo is not on a specific branch
    class EnsureGitBranchAction < Action
      def self.run(params)
        target_branch  = params[:branch]
        current_branch = Helper::Git.current_branch

        if current_branch =~ /#{target_branch}/
          UI.success("Git branch matches `#{target_branch}`, all good! 💪")
        else
          UI.user_error!("Git is not on a branch matching `#{target_branch}`. Current branch is `#{current_branch}`!")
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'Raises an exception if not on a specific git branch'
      end

      def self.details
        [
          'This action will check if your git repo is checked out to a specific branch.',
          'You may only want to make releases from a specific branch, so `ensure_git_branch` will stop a lane if it was accidentally executed on an incorrect branch.'
        ].join("\n")
      end

      def self.available_options
        [
          PantographCore::ConfigItem.new(
            key: :branch,
            env_name: 'ENSURE_GIT_BRANCH_NAME',
            description: 'The branch that should be checked for. String that can be either the full name of the branch or a regex to match',
            type: String,
            default_value: 'master'
          )
        ]
      end

      def self.output
        []
      end

      def self.author
        ['dbachrach', 'Liquidsoul', 'johnknapprs']
      end

      def self.example_code
        [
          "ensure_git_branch # defaults to `master` branch",
          "ensure_git_branch(
            branch: 'develop'
          )"
        ]
      end

      def self.category
        :source_control
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
