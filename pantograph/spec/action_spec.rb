describe Pantograph do
  describe Pantograph::Action do
    describe "#action_name" do
      it "converts the :: format to a readable one" do
        expect(Pantograph::Actions::ZipAction.action_name).to eq('zip')
        expect(Pantograph::Actions::ChangelogFromGitCommitsAction.action_name).to eq('changelog_from_git_commits')
      end
    end

    describe "Easy access to the lane context" do
      it "redirects to the correct class and method" do
        Pantograph::Actions.lane_context[:something] = 1
        expect(Pantograph::Action.lane_context).to eq({ something: 1 })
      end
    end

    describe "can call alias action" do
      it "redirects to the correct class and method" do
        result = Pantograph::PantFile.new.parse("lane :test do
          println(message:\"alias\")
        end").runner.execute(:test)
      end

      it "alias does not crash with no param" do
        Pantograph::Actions.load_external_actions("./pantograph/spec/fixtures/actions")
        expect(UI).to receive(:important).with("modified")
        result = Pantograph::PantFile.new.parse("lane :test do
          somealias
        end").runner.execute(:test)
      end

      it "alias can override option" do
        Pantograph::Actions.load_external_actions("./pantograph/spec/fixtures/actions")
        expect(UI).to receive(:important).with("modified")
        result = Pantograph::PantFile.new.parse("lane :test do
          somealias(example: \"alias\", example_two: 'alias2')
        end").runner.execute(:test)
      end

      it "alias can override option with single param" do
        Pantograph::Actions.load_external_actions("./pantograph/spec/fixtures/actions")
        expect(UI).to receive(:important).with("modified")
        result = Pantograph::PantFile.new.parse("lane :test do
          someshortalias('PARAM')
        end").runner.execute(:test)
      end

      it "alias can override option with no param" do
        Pantograph::Actions.load_external_actions("./pantograph/spec/fixtures/actions")
        expect(UI).to receive(:important).with("modified")
        result = Pantograph::PantFile.new.parse("lane :test do
          somealias_no_param('PARAM')
        end").runner.execute(:test)
      end

      it "alias does not crash - when 'alias_used' not defined" do
        Pantograph::Actions.load_external_actions("./pantograph/spec/fixtures/actions")
        expect(UI).to receive(:important).with("run")
        result = Pantograph::PantFile.new.parse("lane :test do
          alias_no_used_handler_sample_alias('PARAM')
        end").runner.execute(:test)
      end
    end

    describe "Call another action from an action" do
      it "allows the user to call it using `other_action.rocket`" do
        allow(PantographCore::PantographFolder).to receive(:path).and_return(nil)
        Pantograph::Actions.load_external_actions("./pantograph/spec/fixtures/actions")
        ff = Pantograph::PantFile.new('./pantograph/spec/fixtures/pantfiles/PantfileActionFromAction')
        Pantograph::Actions.executed_actions.clear

        response = {
          rocket: "🚀",
          pwd: Dir.pwd
        }
        expect(ff.runner.execute(:something, :ios)).to eq(response)
        expect(Pantograph::Actions.executed_actions.map { |a| a[:name] }).to eq(['from'])
      end

      it "shows only actions called from Pantfile" do
        Pantograph::Actions.load_external_actions("./pantograph/spec/fixtures/actions")
        ff = Pantograph::PantFile.new('./pantograph/spec/fixtures/pantfiles/PantfileActionFromActionWithOtherAction')
        Pantograph::Actions.executed_actions.clear

        ff.runner.execute(:something, :ios)
        expect(Pantograph::Actions.executed_actions.map { |a| a[:name] }).to eq(['from', 'example'])
      end

      it "shows an appropriate error message when trying to directly call an action" do
        Pantograph::Actions.load_external_actions("./pantograph/spec/fixtures/actions")
        ff = Pantograph::PantFile.new('./pantograph/spec/fixtures/pantfiles/PantfileActionFromActionInvalid')
        expect do
          ff.runner.execute(:something, :ios)
        end.to raise_error("To call another action from an action use `other_action.rocket` instead")
      end
    end

    describe "Action.sh" do
      it "delegates to Actions.sh_control_output" do
        mock_status = double(:status, exitstatus: 0)
        expect(Pantograph::Actions).to receive(:sh_control_output).with("ls", "-la").and_yield(mock_status, "Command output")
        Pantograph::Action.sh("ls", "-la") do |status, result|
          expect(status.exitstatus).to eq(0)
          expect(result).to eq("Command output")
        end
      end
    end
  end
end
