module Pantograph
  module Actions
    module SharedValues
      NUMBER_OF_COMMITS = :NUMBER_OF_COMMITS
    end

    class NumberOfCommitsAction < Action
      def self.run(params)
        Pantograph::Helper::Git.is_git?

        type    = params[:all] ? '--all' : 'HEAD'
        commits = Actions.sh("git rev-list #{type} --count").strip.to_i

        Actions.lane_context[:NUMBER_OF_COMMITS] = commits
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'Return the number of commits in current git branch'
      end

      def self.details
      end

      def self.return_type
        :int
      end

      def self.available_options
        [
          PantographCore::ConfigItem.new(
            key: :all,
            env_name: 'NUMBER_OF_COMMITS_ALL',
            optional: true,
            is_string: false,
            description: 'Returns number of all commits instead of current branch'
          )
        ]
      end

      def self.return_value
        'The total number of all commits in current git branch'
      end

      def self.output
        [
          ['NUMBER_OF_COMMITS', 'Total number of git commits']
        ]
      end

      def self.authors
        ['onevcat', 'samuelbeek', 'johnknapprs']
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          '
          ENV["VERSION_NAME"] = number_of_commits
          ',
          '
          build_number = number_of_commits(all: true)
          increment_build_number(build_number: build_number)
          '
        ]
      end

      def self.category
        :source_control
      end
    end
  end
end
