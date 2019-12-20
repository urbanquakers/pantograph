describe Pantograph do
  describe Pantograph::CommandLineHandler do
    it "properly handles default calls" do
      expect(Pantograph::LaneManager).to receive(:cruise_lane).with("mac", "deploy", {}, nil)
      Pantograph::CommandLineHandler.handle(["mac", "deploy"], {})
    end

    it "properly handles calls with custom parameters" do
      expect(Pantograph::LaneManager).to receive(:cruise_lane).with("mac", "deploy",
                                                                    {
                                                                      key: "value",
                                                                      build_number: '123'
                                                                    },
                                                                    nil)
      Pantograph::CommandLineHandler.handle(["mac", "deploy", "key:value", "build_number:123"], {})
    end

    it "properly converts boolean values to real boolean variables" do
      expect(Pantograph::LaneManager).to receive(:cruise_lane).with("mac", "deploy",
                                                                    {
                                                                      key: true,
                                                                      key2: false
                                                                    },
                                                                    nil)
      Pantograph::CommandLineHandler.handle(["mac", "deploy", "key:true", "key2:false"], {})
    end
  end
end
