module Pantograph
  module Actions
    module SharedValues
      ENSURE_GIT_STATUS_CLEAN = :ENSURE_GIT_STATUS_CLEAN
    end

    # Raises an exception and stop the lane execution if the repo is not in a clean state
    class EnsureGitStatusCleanAction < Action
      def self.run(params)
        repo_status = Helper::Git.repo_status

        if repo_status.empty?
          UI.success('Git status is clean, all good! 💪')
          Actions.lane_context[SharedValues::ENSURE_GIT_STATUS_CLEAN] = true
        else
          error_message = [
            'Git repository is dirty! Please ensure the repo is in a clean state by committing/stashing/discarding all changes first.',
            'Uncommitted changes:',
            repo_status
          ].join("\n")

          UI.user_error!(error_message)
        end
      end

      def self.description
        'Raises error if there are uncommitted git changes'
      end

      def self.details
      end

      def self.output
        [
          ['ENSURE_GIT_STATUS_CLEAN', 'Returns `true` if status clean when executed']
        ]
      end

      def self.author
        ['lmirosevic', 'antondomashnev', 'johnknapprs']
      end

      def self.example_code
        [
          'before_all do
             # Prevent pantograph from running lanes when git is in a dirty state
             ensure_git_status_clean
           end'
        ]
      end

      def self.available_options
        []
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
