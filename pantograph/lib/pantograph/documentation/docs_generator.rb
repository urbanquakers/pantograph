module Pantograph
  class DocsGenerator
    def self.run(ff, output_path = nil)
      output_path ||= File.join(PantographCore::PantographFolder.path || '.', 'README.md')

      output = ["pantograph documentation"]
      output << "================"

      output << "# Installation"
      output << ""
      output << "Make sure you have the latest version of the Xcode command line tools installed:"
      output << ""
      output << "```"
      output << "xcode-select --install"
      output << "```"
      output << ""
      output << "Install _pantograph_ using"
      output << "```"
      output << "gem install pantograph"
      output << "```"
      output << "or alternatively using `brew cask install pantograph`"
      output << ""
      output << "# Available Actions"

      all_keys = ff.runner.lanes.keys.reject(&:nil?)
      all_keys.unshift(nil) # because we want root elements on top. always! They have key nil

      all_keys.each do |platform|
        lanes = ff.runner.lanes[platform]

        if lanes.nil? || lanes.empty? || lanes.all? { |_, lane| lane.is_private }
          next
        end

        output << "## #{formatted_platform(platform)}" if platform

        lanes.each do |lane_name, lane|
          next if lane.is_private
          output << render(platform, lane_name, lane.description.join("\n\n"))
        end

        output << ""
        output << "----"
        output << ""
      end

      output << "This README.md is auto-generated and will be re-generated every time [pantograph](https://pantograph.tools) is run."
      output << "More information about pantograph can be found on [pantograph.tools](https://pantograph.tools)."
      output << "The documentation of pantograph can be found on [docs.pantograph.tools](https://docs.pantograph.tools)."
      output << ""

      begin
        File.write(output_path, output.join("\n"))
        UI.success("Successfully generated documentation at path '#{File.expand_path(output_path)}'") if PantographCore::Globals.verbose?
      rescue => ex
        UI.error(ex)
        UI.error("Couldn't save pantograph documentation at path '#{File.expand_path(output_path)}', make sure you have write access to the containing directory.")
      end
    end

    #####################################################
    # @!group Helper
    #####################################################

    def self.formatted_platform(pl)
      pl = pl.to_s
      case pl
      when 'ios'
        'iOS'
      when 'android'
        'Android'
      when 'mac'
        'MacOS'
      else
        pl
      end

    end

    # @param platform [String]
    # @param lane [Pantograph::Lane]
    # @param description [String]
    def self.render(platform, lane, description)
      full_name = [platform, lane].reject(&:nil?).join(' ')

      output = []
      output << "### #{full_name}"
      output << "```"
      output << "pantograph #{full_name}"
      output << "```"
      output << description
      output
    end
  end
end
