module Pantograph
  module Actions
    class BundleInstallAction < Action
      # rubocop:disable Metrics/PerceivedComplexity
      def self.run(params)
        if gemfile_exists?(params)
          cmd = ['bundle install']

          cmd << "--binstubs #{params[:binstubs]}" if params[:binstubs]
          cmd << "--clean" if params[:clean]
          cmd << "--full-index" if params[:full_index]
          cmd << "--gemfile #{params[:gemfile]}" if params[:gemfile]
          cmd << "--jobs #{params[:jobs]}" if params[:jobs]
          cmd << "--local" if params[:local]
          cmd << "--deployment" if params[:deployment]
          cmd << "--no-cache" if params[:no_cache]
          cmd << "--no_prune" if params[:no_prune]
          cmd << "--path #{params[:path]}" if params[:path]
          cmd << "--system" if params[:system]
          cmd << "--quiet" if params[:quiet]
          cmd << "--retry #{params[:retry]}" if params[:retry]
          cmd << "--shebang" if params[:shebang]
          cmd << "--standalone #{params[:standalone]}" if params[:standalone]
          cmd << "--trust-policy" if params[:trust_policy]
          cmd << "--without #{params[:without]}" if params[:without]
          cmd << "--with #{params[:with]}" if params[:with]

          return sh(cmd.join(' '))
        else
          UI.message("No Gemfile found")
        end
      end
      # rubocop:enable Metrics/PerceivedComplexity

      def self.gemfile_exists?(params)
        possible_gemfiles = ['Gemfile', 'gemfile']
        possible_gemfiles.insert(0, params[:gemfile]) if params[:gemfile]
        possible_gemfiles.each do |gemfile|
          gemfile = File.absolute_path(gemfile)
          return true if File.exist?(gemfile)
          UI.message("Gemfile not found at: '#{gemfile}'")
        end
        return false
      end

      def self.description
        'This action runs `bundle install` (if available)'
      end

      def self.is_supported?(platform)
        true
      end

      def self.author
        ["birmacher", "koglinjg"]
      end

      def self.example_code
        nil
      end

      def self.category
        :misc
      end

      def self.available_options
        [
          PantographCore::ConfigItem.new(key: :binstubs,
                                       env_name: 'BUNDLE_INSTALL_BINSTUBS',
                                       description: 'Generate bin stubs for bundled gems to ./bin',
                                       optional: true),
          PantographCore::ConfigItem.new(key: :clean,
                                       env_name: 'BUNDLE_INSTALL_CLEAN',
                                       description: 'Run bundle clean automatically after install',
                                       is_string: false,
                                       default_value: false),
          PantographCore::ConfigItem.new(key: :full_index,
                                       env_name: 'BUNDLE_INSTALL_FULL_INDEX',
                                       description: 'Use the rubygems modern index instead of the API endpoint',
                                       is_string: false,
                                       default_value: false),
          PantographCore::ConfigItem.new(key: :gemfile,
                                       env_name: 'BUNDLE_INSTALL_GEMFILE',
                                       description: 'Use the specified gemfile instead of Gemfile',
                                       optional: true),
          PantographCore::ConfigItem.new(key: :jobs,
                                       env_name: 'BUNDLE_INSTALL_JOBS',
                                       description: 'Install gems using parallel workers',
                                       is_string: false,
                                       type: Boolean,
                                       optional: true),
          PantographCore::ConfigItem.new(key: :local,
                                       env_name: 'BUNDLE_INSTALL_LOCAL',
                                       description: 'Do not attempt to fetch gems remotely and use the gem cache instead',
                                       is_string: false,
                                       default_value: false),
          PantographCore::ConfigItem.new(key: :deployment,
                                       env_name: 'BUNDLE_INSTALL_DEPLOYMENT',
                                       description: 'Install using defaults tuned for deployment and CI environments',
                                       is_string: false,
                                       default_value: false),
          PantographCore::ConfigItem.new(key: :no_cache,
                                       env_name: 'BUNDLE_INSTALL_NO_CACHE',
                                       description: "Don't update the existing gem cache",
                                       is_string: false,
                                       default_value: false),
          PantographCore::ConfigItem.new(key: :no_prune,
                                       env_name: 'BUNDLE_INSTALL_NO_PRUNE',
                                       description: "Don't remove stale gems from the cache",
                                       is_string: false,
                                       default_value: false),
          PantographCore::ConfigItem.new(key: :path,
                                       env_name: 'BUNDLE_INSTALL_PATH',
                                       description: 'Specify a different path than the system default ($BUNDLE_PATH or $GEM_HOME). Bundler will remember this value for future installs on this machine',
                                       optional: true),
          PantographCore::ConfigItem.new(key: :system,
                                       env_name: 'BUNDLE_INSTALL_SYSTEM',
                                       description: 'Install to the system location ($BUNDLE_PATH or $GEM_HOME) even if the bundle was previously installed somewhere else for this application',
                                       is_string: false,
                                       default_value: false),
          PantographCore::ConfigItem.new(key: :quiet,
                                       env_name: 'BUNDLE_INSTALL_QUIET',
                                       description: 'Only output warnings and errors',
                                       is_string: false,
                                       default_value: false),
          PantographCore::ConfigItem.new(key: :retry,
                                       env_name: 'BUNDLE_INSTALL_RETRY',
                                       description: 'Retry network and git requests that have failed',
                                       is_string: false,
                                       type: Boolean,
                                       optional: true),
          PantographCore::ConfigItem.new(key: :shebang,
                                       env_name: 'BUNDLE_INSTALL_SHEBANG',
                                       description: "Specify a different shebang executable name than the default (usually 'ruby')",
                                       optional: true),
          PantographCore::ConfigItem.new(key: :standalone,
                                       env_name: 'BUNDLE_INSTALL_STANDALONE',
                                       description: 'Make a bundle that can work without the Bundler runtime',
                                       optional: true),
          PantographCore::ConfigItem.new(key: :trust_policy,
                                       env_name: 'BUNDLE_INSTALL_TRUST_POLICY',
                                       description: 'Sets level of security when dealing with signed gems. Accepts `LowSecurity`, `MediumSecurity` and `HighSecurity` as values',
                                       optional: true),
          PantographCore::ConfigItem.new(key: :without,
                                       env_name: 'BUNDLE_INSTALL_WITHOUT',
                                       description: 'Exclude gems that are part of the specified named group',
                                       optional: true),
          PantographCore::ConfigItem.new(key: :with,
                                       env_name: 'BUNDLE_INSTALL_WITH',
                                       description: 'Include gems that are part of the specified named group',
                                       optional: true)
        ]
      end
    end
  end
end
