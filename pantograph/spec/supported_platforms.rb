describe Pantograph do
  describe Pantograph::Action do
    describe "#all" do
      it "Contains 3 default supported platforms" do
        expect(Pantograph::SupportedPlatforms.all.count).to eq(3)
      end
    end
    describe "#extra=" do
      after :each do
        Pantograph::SupportedPlatforms.extra = []
      end
      it "allows to add new platforms the list of supported ones" do
        expect(PantographCore::UI).to receive(:important).with("Setting '[:abcdef]' as extra SupportedPlatforms")
        Pantograph::SupportedPlatforms.extra = [:abcdef]
        expect(Pantograph::SupportedPlatforms.all).to include(:abcdef)
      end
      it "doesn't break if you pass nil" do
        expect(PantographCore::UI).to receive(:important).with("Setting '[]' as extra SupportedPlatforms")
        Pantograph::SupportedPlatforms.extra = nil
        expect(Pantograph::SupportedPlatforms.all.count).to eq(3)
      end
    end
  end
end
