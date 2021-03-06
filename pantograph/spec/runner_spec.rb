describe Pantograph do
  describe Pantograph::Runner do
    describe "#available_lanes" do
      before do
        @ff = Pantograph::PantFile.new('./pantograph/spec/fixtures/pantfiles/PantfileGrouped')
      end

      it "lists all available lanes" do
        expect(@ff.runner.available_lanes).to eq(["test", "anotherroot", "mac beta", "windows beta", "windows release", "linux beta", "linux witherror", "linux unsupported_action"])
      end

      it "allows filtering of results" do
        expect(@ff.runner.available_lanes('linux')).to eq(["linux beta", "linux witherror", "linux unsupported_action"])
      end

      it "returns an empty array if invalid input is given" do
        expect(@ff.runner.available_lanes('asdfasdfasdf')).to eq([])
      end

      it "doesn't show private lanes" do
        expect(@ff.runner.available_lanes).to_not(include('linux such_private'))
      end

      # describe "step_name override" do
      #   it "handle overriding of step_name" do
      #     allow(Pantograph::Actions).to receive(:execute_action).with('Let it Frame')
      #     @ff.runner.execute_action(:frameit, Pantograph::Actions::FrameitAction, [{ step_name: "Let it Frame" }])
      #   end
      #   it "rely on step_text when no step_name given" do
      #     allow(Pantograph::Actions).to receive(:execute_action).with('frameit')

      #     @ff.runner.execute_action(:frameit, Pantograph::Actions::FrameitAction, [{}])
      #   end
      # end
    end
  end
end
