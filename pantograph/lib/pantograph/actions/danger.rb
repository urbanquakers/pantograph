module Pantograph
  module Actions
    class DangerAction < Action
      def self.run(params)
        Actions.verify_gem!('danger')
        cmd = []

        cmd << 'bundle exec' if params[:use_bundle_exec] && shell_out_should_use_bundle_exec?
        cmd << 'danger'
        cmd << '--verbose' if params[:verbose]

        danger_id = params[:danger_id]
        dangerfile = params[:dangerfile]
        base = params[:base]
        head = params[:head]
        pr = params[:pr]
        cmd << "--danger_id=#{danger_id}" if danger_id
        cmd << "--dangerfile=#{dangerfile}" if dangerfile
        cmd << "--fail-on-errors=true" if params[:fail_on_errors]
        cmd << "--new-comment" if params[:new_comment]
        cmd << "--remove-previous-comments" if params[:remove_previous_comments]
        cmd << "--base=#{base}" if base
        cmd << "--head=#{head}" if head
        cmd << "pr #{pr}" if pr

        ENV['DANGER_GITHUB_API_TOKEN'] = params[:github_api_token] if params[:github_api_token]

        Actions.sh(cmd.join(' '))
      end

      def self.description
        'Runs `danger` for the project'
      end

      def self.details
        [
          'Formalize your Pull Request etiquette.',
          'More information: [https://github.com/danger/danger](https://github.com/danger/danger).'
        ].join("\n")
      end

      def self.available_options
        [
          PantographCore::ConfigItem.new(key: :use_bundle_exec,
                                       env_name: 'DANGER_USE_BUNDLE_EXEC',
                                       description: 'Use bundle exec when there is a Gemfile presented',
                                       is_string: false,
                                       default_value: true),
          PantographCore::ConfigItem.new(key: :verbose,
                                       env_name: 'DANGER_VERBOSE',
                                       description: 'Show more debugging information',
                                       is_string: false,
                                       default_value: false),
          PantographCore::ConfigItem.new(key: :danger_id,
                                       env_name: 'DANGER_ID',
                                       description: 'The identifier of this Danger instance',
                                       type: String,
                                       optional: true),
          PantographCore::ConfigItem.new(key: :dangerfile,
                                       env_name: 'DANGER_DANGERFILE',
                                       description: 'The location of your Dangerfile',
                                       type: String,
                                       optional: true),
          PantographCore::ConfigItem.new(key: :github_api_token,
                                       env_name: 'DANGER_GITHUB_API_TOKEN',
                                       description: 'GitHub API token for danger',
                                       sensitive: true,
                                       type: String,
                                       optional: true),
          PantographCore::ConfigItem.new(key: :fail_on_errors,
                                       env_name: 'DANGER_FAIL_ON_ERRORS',
                                       description: 'Should always fail the build process, defaults to false',
                                       is_string: false,
                                       optional: true,
                                       default_value: false),
          PantographCore::ConfigItem.new(key: :new_comment,
                                       env_name: 'DANGER_NEW_COMMENT',
                                       description: 'Makes Danger post a new comment instead of editing its previous one',
                                       is_string: false,
                                       optional: true,
                                       default_value: false),
          PantographCore::ConfigItem.new(key: :remove_previous_comments,
                                       env_name: 'DANGER_REMOVE_PREVIOUS_COMMENT',
                                       description: 'Makes Danger remove all previous comment and create a new one in the end of the list',
                                       is_string: false,
                                       optional: true,
                                       default_value: false),
          PantographCore::ConfigItem.new(key: :base,
                                       env_name: 'DANGER_BASE',
                                       description: 'A branch/tag/commit to use as the base of the diff. [master|dev|stable]',
                                       type: String,
                                       optional: true),
          PantographCore::ConfigItem.new(key: :head,
                                       env_name: 'DANGER_HEAD',
                                       description: 'A branch/tag/commit to use as the head. [master|dev|stable]',
                                       type: String,
                                       optional: true),
          PantographCore::ConfigItem.new(key: :pr,
                                       env_name: 'DANGER_PR',
                                       description: 'Run danger on a specific pull request. e.g. \"https://github.com/danger/danger/pull/518\"',
                                       type: String,
                                       optional: true)
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
        :misc
      end

      def self.authors
        ['KrauseFx']
      end
    end
  end
end
