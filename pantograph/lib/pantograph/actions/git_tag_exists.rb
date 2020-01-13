module Pantograph
  module Actions
    class GitTagExistsAction < Action
      module SharedValues
        GIT_TAG_EXISTS ||= :GIT_TAG_EXISTS
      end

      def self.run(params)
        tag_exists = true

        Actions.sh(
          "git rev-parse -q --verify refs/tags/#{params[:tag].shellescape}",
          log: PantographCore::Globals.verbose?,
          error_callback: ->(result) { tag_exists = false }
        )

        Actions.lane_context[SharedValues::GIT_TAG_EXISTS] = tag_exists
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'Checks if the git tag with the given name exists'
      end

      def self.available_options
        [
          PantographCore::ConfigItem.new(
            key: :tag,
            env_name: 'GIT_TAG_EXISTS_TAG',
            description: 'The tag name that should be checked',
            is_string: true
          )
        ]
      end

      def self.return_value
        'Returns Boolean value whether the tag exists'
      end

      def self.output
        [
          ['GIT_TAG_EXISTS', 'Boolean value whether tag exists']
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
          'if git_tag_exists(tag: "1.1.0")
            UI.message("Git Tag Exists!")
          end'
        ]
      end

      def self.category
        :source_control
      end
    end
  end
end
