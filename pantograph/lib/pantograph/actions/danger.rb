module Pantograph
  module Actions
    class DangerAction < Action
      def self.run(params)
        ENV['DANGER_GITHUB_API_TOKEN'] = params[:github_api_token] if params[:github_api_token]

        danger_cmd = []

        if params[:use_bundle_exec] && shell_out_should_use_bundle_exec?
          danger_cmd << 'bundle exec'
        end

        danger_cmd << 'danger'
        danger_cmd << "--dangerfile=#{params[:dangerfile]}"
        danger_cmd << "--new-comment"                     if params[:new_comment]
        danger_cmd << "--remove-previous-comments"        if params[:remove_previous_comments]
        danger_cmd << "--base=#{params[:base]}"           if params[:base]
        danger_cmd << "--head=#{params[:head]}"           if params[:head]
        danger_cmd << "pr #{params[:pr]}"                 if params[:pr]
        danger_cmd << "--danger_id=#{params[:danger_id]}" if params[:danger_id]
        danger_cmd << '--verbose'                         if params[:verbose]

        danger_cmd << "--fail-on-errors=#{params[:fail_on_errors]}"
        danger_cmd = danger_cmd.join(' ')

        Actions.sh(danger_cmd)
      end

      def self.description
        'Runs `danger` for the project'
      end

      def self.details
        [
          'Stop Saying your Forgot in Source Control',
          'More information: [https://github.com/danger/danger](https://github.com/danger/danger).'
        ].join("\n")
      end

      def self.available_options
        [
          PantographCore::ConfigItem.new(
            key: :use_bundle_exec,
            env_name: 'DANGER_USE_BUNDLE_EXEC',
            description: 'Use bundle exec when there is a Gemfile presented',
            is_string: false,
            default_value: true
          ),
          PantographCore::ConfigItem.new(
            key: :verbose,
            env_name: 'DANGER_VERBOSE',
            description: 'Show more debugging information',
            is_string: false,
            default_value: false
          ),
          PantographCore::ConfigItem.new(
            key: :danger_id,
            env_name: 'DANGER_ID',
            description: 'The identifier of this Danger instance',
            type: String,
            optional: true
          ),
          PantographCore::ConfigItem.new(
            key: :dangerfile,
            env_name: 'DANGER_DANGERFILE',
            description: 'The location of your Dangerfile',
            type: String,
            optional: false,
            default_value: 'Dangerfile'
          ),
          PantographCore::ConfigItem.new(
            key: :github_api_token,
            env_name: 'DANGER_GITHUB_API_TOKEN',
            description: 'GitHub API token for danger',
            sensitive: true,
            type: String,
            optional: true
          ),
          PantographCore::ConfigItem.new(
            key: :fail_on_errors,
            env_name: 'DANGER_FAIL_ON_ERRORS',
            description: 'Should always fail the build process, defaults to false',
            is_string: false,
            optional: true,
            default_value: false
          ),
          PantographCore::ConfigItem.new(
            key: :new_comment,
            env_name: 'DANGER_NEW_COMMENT',
            description: 'Makes Danger post a new comment instead of editing its previous one',
            is_string: false,
            optional: true,
            default_value: false
          ),
          PantographCore::ConfigItem.new(
            key: :remove_previous_comments,
            env_name: 'DANGER_REMOVE_PREVIOUS_COMMENT',
            description: 'Makes Danger remove all previous comment and create a new one in the end of the list',
            is_string: false,
            optional: true,
            default_value: false
          ),
          PantographCore::ConfigItem.new(
            key: :base,
            env_name: 'DANGER_BASE',
            description: 'A branch/tag/commit to use as the base of the diff. [master|dev|stable]',
            type: String,
            optional: true
          ),
          PantographCore::ConfigItem.new(
            key: :head,
            env_name: 'DANGER_HEAD',
            description: 'A branch/tag/commit to use as the head. [master|dev|stable]',
            type: String,
            optional: true
          ),
          PantographCore::ConfigItem.new(
            key: :pr,
            env_name: 'DANGER_PR',
            description: 'Run danger on a specific pull request. e.g. \"https://github.com/danger/danger/pull/518\"',
            type: String,
            optional: true
          )
        ]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'danger',
          'danger(
            danger_id: "unit-tests",
            dangerfile: "tests/MyOtherDangerFile",
            github_api_token: ENV["GITHUB_API_TOKEN"],
            verbose: true
          )'
        ]
      end

      def self.category
        :source_control
      end

      def self.authors
        ['KrauseFx', 'johnknapprs']
      end
    end
  end
end
