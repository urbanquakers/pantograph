describe Pantograph do
  describe Pantograph::PantFile do
    describe "Lane Context Quick Access" do
      it "allows you easily access the lane context" do
        result = Pantograph::PantFile.new.parse("lane :my_lane_name do
          lane_context[SharedValues::LANE_NAME]
        end").runner.execute(:my_lane_name)

        expect(result).to eq("my_lane_name")
      end
    end
  end
end
