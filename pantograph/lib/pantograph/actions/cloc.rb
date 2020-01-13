module Pantograph
  module Actions
    class ClocAction < Action
      def self.run(params)
        output_type = params[:output_type]

        cloc_cmd = []
        cloc_cmd << params[:binary_path]
        cloc_cmd << params[:source_directory]
        cloc_cmd << "--exclude-dir=#{params[:exclude_dir]}" if params[:exclude_dir]
        cloc_cmd << '--by-file' if params[:list_each_file]
        cloc_cmd << "--#{output_type}"
        cloc_cmd << "--report-file=#{params[:output_directory]}/cloc.#{output_type}"
        cloc_cmd = cloc_cmd.join(' ').strip

        Actions.sh(cloc_cmd)
      end

      def self.description
        'Generates a Code Count that can be read by Jenkins (xml format)'
      end

      def self.details
        [
          'This action will run cloc to generate a code count report',
          'See [https://github.com/AlDanial/cloc](https://github.com/AlDanial/cloc) for more information.'
        ].join("\n")
      end

      def self.available_options
        [
          PantographCore::ConfigItem.new(
            key: :binary_path,
            env_name: 'CLOC_BINARY_PATH',
            description: 'Where the cloc binary lives on your system (full path including "cloc")',
            optional: true,
            is_string: true,
            default_value: '/usr/local/bin/cloc'
          ),
          PantographCore::ConfigItem.new(
            key: :exclude_dir,
            env_name: 'CLOC_EXCLUDE_DIR',
            description: 'Comma separated list of directories to exclude',
            optional: true,
            is_string: true
          ),
          PantographCore::ConfigItem.new(
            key: :source_directory,
            env_name: 'CLOC_SOURCE_DIRECTORY',
            description: 'Starting point for Cloc analysis',
            is_string: true,
            default_value: '.'
          ),
          PantographCore::ConfigItem.new(
            key: :output_directory,
            env_name: 'CLOC_OUTPUT_DIRECTORY',
            description: 'Where to put the generated report file',
            is_string: true,
            default_value: 'pantograph/reports'
          ),
          PantographCore::ConfigItem.new(
            key: :output_type,
            env_name: 'CLOC_OUTPUT_TYPE',
            description: 'Output file type: xml, yaml, cvs, json',
            is_string: true,
            default_value: 'yaml'
          ),
          PantographCore::ConfigItem.new(
            key: :list_each_file,
            env_name: 'CLOC_LIST_EACH_FILE',
            description: 'List each individual file in cloc report',
            is_string: false,
            default_value: true
          )
        ]
      end

      def self.authors
        ['johnknapprs']
      end

      def self.is_supported?(platform)
        [:mac].include?(platform)
      end

      def self.example_code
        [
          '  # Generate JSON report of project code count
          cloc(
             exclude_dir: "build",
             source_directory: ".",
             output_directory: "pantograph/reports",
             output_type: "json"
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
