describe Pantograph do
  describe Pantograph::PantFile do
    describe "#execute_action" do
      let(:step_name) { "My Step" }

      it "stores the action properly" do
        Pantograph::Actions.execute_action(step_name) {}
        result = Pantograph::Actions.executed_actions.last
        expect(result[:name]).to eq(step_name)
        expect(result[:error]).to eq(nil)
      end

      it "stores the action properly when an exeception occurred" do
        expect do
          Pantograph::Actions.execute_action(step_name) do
            UI.user_error!("Some error")
          end
        end.to raise_error("Some error")

        result = Pantograph::Actions.executed_actions.last
        expect(result[:name]).to eq(step_name)
        expect(result[:error]).to include("Some error")
        expect(result[:error]).to include("actions_helper.rb")
      end
    end

    it "#action_class_ref" do
      expect(Pantograph::Actions.action_class_ref("puts")).to eq(Pantograph::Actions::PutsAction)
      expect(Pantograph::Actions.action_class_ref(:ssh)).to eq(Pantograph::Actions::SshAction)
      expect(Pantograph::Actions.action_class_ref('notExistentObv')).to eq(nil)
    end

    it "#load_default_actions" do
      expect(Pantograph::Actions.load_default_actions.count).to be > 6
    end

    describe "#load_external_actions" do
      it "can load custom paths" do
        Pantograph::Actions.load_external_actions("./pantograph/spec/fixtures/actions")
        Pantograph::Actions::ExampleActionAction.run(nil)
        Pantograph::Actions::ExampleActionSecondAction.run(nil)
        Pantograph::Actions::ArchiveAction.run(nil)
      end

      it "throws an error if plugin is damaged" do
        expect(UI).to receive(:user_error!).with("Action 'broken_action' is damaged!", { show_github_issues: true })
        Pantograph::Actions.load_external_actions("./pantograph/spec/fixtures/broken_actions")
      end

      it "throws errors when syntax is incorrect" do
        content = File.read('./pantograph/spec/fixtures/broken_files/broken_file.rb', encoding: 'utf-8')
        expect(UI).to receive(:content_error).with(content, '7')
        expect(UI).to receive(:content_error).with(content, '8')
        expect(UI).to receive(:user_error!).with("Syntax error in broken_file.rb")
        Pantograph::Actions.load_external_actions("./pantograph/spec/fixtures/broken_files")
      end
    end

    describe "#deprecated_actions" do
      it "is class action" do
        Pantograph::Actions.load_external_actions("./pantograph/spec/fixtures/actions")
        require_relative './fixtures/broken_actions/broken_action.rb'

        # An action
        example_action_ref = Pantograph::Actions.action_class_ref("example_action")
        expect(Pantograph::Actions.is_class_action?(example_action_ref)).to eq(true)

        # Not an action
        broken_action_ref = Pantograph::Actions::BrokenAction
        expect(Pantograph::Actions.is_class_action?(broken_action_ref)).to eq(false)

        # Nil
        expect(Pantograph::Actions.is_class_action?(nil)).to eq(false)
      end

      it "is action deprecated" do
        Pantograph::Actions.load_external_actions("./pantograph/spec/fixtures/actions")
        require_relative './fixtures/broken_actions/broken_action.rb'
        require_relative './fixtures/deprecated_actions/deprecated_action.rb'

        # An action (not deprecated)
        example_action_ref = Pantograph::Actions.action_class_ref("example_action")
        expect(Pantograph::Actions.is_deprecated?(example_action_ref)).to eq(false)

        # An action (depreated)
        deprecated_action_ref = Pantograph::Actions.action_class_ref("deprecated_action")
        expect(Pantograph::Actions.is_deprecated?(deprecated_action_ref)).to eq(true)

        # Not an action
        broken_action_ref = Pantograph::Actions::BrokenAction
        expect(Pantograph::Actions.is_deprecated?(broken_action_ref)).to eq(false)

        # Nil
        expect(Pantograph::Actions.is_deprecated?(nil)).to eq(false)
      end
    end
  end
end
