module Pantograph
  module Actions
    class ImportFromGitAction < Action
      def self.run(params)
        # this is implemented in the pant_file.rb
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'Import another Pantfile from a remote git repository to use its lanes'
      end

      def self.details
        'This is useful when sharing the same lanes across multiple projects'
      end

      def self.available_options
        [
          PantographCore::ConfigItem.new(
            key: :url,
            description: 'The URL of the repository to import the Pantfile from',
            default_value: nil,
            optional: false
          ),
          PantographCore::ConfigItem.new(
            key: :branch,
            description: 'The branch or tag to check-out on the repository',
            default_value: 'master',
            optional: true
          ),
          PantographCore::ConfigItem.new(
            key: :path,
            description: 'The path of the Pantfile in the repository',
            default_value: 'pantograph/Pantfile',
            optional: true
          ),
          PantographCore::ConfigItem.new(
            key: :version,
            description: 'The version to checkout on the repository. Optimistic match operator or multiple conditions can be used to select the version within constraints',
            default_value: nil,
            is_string: false,
            optional: true
          )
        ]
      end

      def self.authors
        ['fabiomassimo', 'KrauseFx', 'Liquidsoul', 'johnknapprs']
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          ' # Simple import on master branch
            import_from_git(
              url: "git@github.com:urbanquakers/pantograph.git"
            )
          ',
          ' # Import a Pantfile with an Optimistic version match operator
            import_from_git(
              url: "git@github.com:urbanquakers/pantograph.git",
              branch: "master",
              path: "pantograph/Pantfile",
              version: "~> 1.0.0"
            )
          ',
          ' # Import a Pantfile with multiple version conditions
            import_from_git(
              url: "git@github.com:urbanquakers/pantograph.git", # The URL of the repository to import the Pantfile from.
              branch: "development", # The branch to checkout on the repository
              version: [">= 1.1.0", "< 2.0.0"]
            )
          '
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
