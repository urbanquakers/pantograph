module Pantograph
  module Actions
    class AddExtraPlatformsAction < Action
      def self.run(params)
        UI.verbose("Before injecting extra platforms: #{Pantograph::SupportedPlatforms.all}")
        Pantograph::SupportedPlatforms.extra = params[:platforms]
        UI.verbose("After injecting extra platforms (#{params[:platforms]})...: #{Pantograph::SupportedPlatforms.all}")
      end

      def self.description
        "Modify the default list of supported platforms"
      end

      def self.available_options
        [
          PantographCore::ConfigItem.new(key: :platforms,
                                       optional: false,
                                       type: Array,
                                       default_value: "",
                                       description: "The optional extra platforms to support")
        ]
      end

      def self.authors
        ["lacostej"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'add_extra_platforms(
            platforms: [:windows, :neogeo]
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
