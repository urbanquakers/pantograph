
module Pantograph
  module Actions
    module SharedValues
    end

    class RsyncAction < Action
      def self.run(params)
        rsync_cmd = ['rsync']
        rsync_cmd << params[:extra]
        rsync_cmd << params[:source]
        rsync_cmd << params[:destination]
        Actions.sh(rsync_cmd.join(" "))
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'Rsync files from :source to :destination'
      end

      def self.details
        'A wrapper around `rsync`, which is a tool that lets you synchronize files, including permissions and so on. For a more detailed information about `rsync`, please see [rsync(1) man page](https://linux.die.net/man/1/rsync).'
      end

      def self.available_options
        [
          PantographCore::ConfigItem.new(key: :extra,
                                       short_option: '-X',
                                       env_name: 'RSYNC_EXTRA', # The name of the environment variable
                                       description: 'Port', # a short description of this parameter
                                       optional: true,
                                       default_value: '-av',
                                       type: String),
          PantographCore::ConfigItem.new(key: :source,
                                       short_option: '-S',
                                       env_name: 'RSYNC_SRC', # The name of the environment variable
                                       description: 'source file/folder', # a short description of this parameter
                                       optional: false,
                                       type: String),
          PantographCore::ConfigItem.new(key: :destination,
                                       short_option: '-D',
                                       env_name: 'RSYNC_DST', # The name of the environment variable
                                       description: 'destination file/folder', # a short description of this parameter
                                       optional: false,
                                       type: String)
        ]
      end

      def self.authors
        ['hjanuschka']
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'rsync(
            source: "root@host:/tmp/1.txt",
            destination: "/tmp/local_file.txt"
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
