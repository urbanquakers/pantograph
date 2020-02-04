module Pantograph
  module Actions
    class PluginScoresAction < Action
      def self.run(params)
        require_relative '../helper/plugin_scores_helper.rb'
        require "erb"

        plugins = fetch_plugins(params[:cache_path]).sort_by { |v| v.data[:overall_score] }.reverse

        result = "<!--\nAuto generated, please only modify https://github.com/urbanquakers/pantograph/blob/master/pantograph/actions/plugin_scores.rb\n-->\n"
        result += "{!docs/includes/setup-pantograph-header.md!}\n"
        result += "# Available Plugins\n\n\n"
        result += plugins.collect do |current_plugin|
          @plugin = current_plugin
          result = ERB.new(File.read(params[:template_path]), 0, '-').result(binding) # https://web.archive.org/web/20160430190141/www.rrn.dk/rubys-erb-templating-system
        end.join("\n")

        File.write(File.join("docs", params[:output_path]), result)
      end

      def self.fetch_plugins(cache_path)
        page = 1
        plugins = []
        loop do
          url = "https://rubygems.org/api/v1/search.json?query=pantograph-plugin-&page=#{page}"
          puts("RubyGems API Request: #{url}")
          results = JSON.parse(open(url).read)
          break if results.count == 0

          plugins += results.collect do |current|
            next if self.hidden_plugins.include?(current['name'])

            Pantograph::Helper::PluginScoresHelper::PantographPluginScore.new(current, cache_path)
          end.compact

          page += 1
        end

        return plugins
      end

      # Metadata
      def self.available_options
        [
          PantographCore::ConfigItem.new(key: :output_path),
          PantographCore::ConfigItem.new(key: :template_path),
          PantographCore::ConfigItem.new(key: :cache_path)
        ]
      end

      def self.authors
        ["KrauseFx"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.category
        :misc
      end

      # Those are plugins that are now part of pantograph core actions, so we don't want to show them in the directory
      def self.hidden_plugins
        [
          "pantograph-plugin-update_project_codesigning"
        ]
      end
    end
  end
end
