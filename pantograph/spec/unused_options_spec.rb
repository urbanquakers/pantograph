describe Pantograph do
  describe Pantograph::Action do
    describe "No unused options" do
      let(:all_exceptions) do
        %w(
          import_from_git
          artifactory
          notification
          set_changelog
          sh
          plugin_scores
          puts
          println
          echo
        )
      end

      Pantograph::ActionsList.all_actions do |action, name|
        next unless action.available_options.kind_of?(Array)
        next unless action.available_options.last.kind_of?(PantographCore::ConfigItem)

        it "No unused parameters in '#{name}'" do
          next if all_exceptions.include?(name)
          content = File.read(File.join("pantograph", "lib", "pantograph", "actions", name + ".rb"))
          action.available_options.each do |option|
            unless content.include?("[:#{option.key}]")
              UI.user_error!("Action '#{name}' doesn't use the option :#{option.key}")
            end
          end
        end
      end
    end
  end
end
