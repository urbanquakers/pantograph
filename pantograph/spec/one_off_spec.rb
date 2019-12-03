require 'pantograph/one_off'

describe Pantograph do
  describe Pantograph::OneOff do
    describe "Valid parameters" do
      before do
        @runner = "runner"
        expect(Pantograph::Runner).to receive(:new).and_return(@runner)
      end

      it "calls load_actions to load all built-in actions" do
        action = 'rocket'
        expect(Pantograph).to receive(:load_actions)

        expect(@runner).to receive(:execute_action).with(
          action, Pantograph::Actions::RocketAction, [{}], { custom_dir: "." }
        )
        Pantograph::OneOff.execute(args: [action])
      end

      it "works with no parameters" do
        action = 'puts'

        expect(@runner).to receive(:execute_action).with(
          action, Pantograph::Actions::PutsAction, [{}], { custom_dir: "." }
        )

        Pantograph::OneOff.execute(args: [action])
      end

      it "automatically converts the parameters" do
        action = 'slack'

        expect(@runner).to receive(:execute_action).with(
          action, Pantograph::Actions::SlackAction, [{ message: "something" }], { custom_dir: "." }
        )

        Pantograph::OneOff.execute(args: [action, "message:something"])
      end
    end
  end
end
