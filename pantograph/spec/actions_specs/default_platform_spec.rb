describe Pantograph do
  describe Pantograph::PantFile do
    describe "Default Platform Action" do
      it "stores the default platform and converts to a symbol" do
        Pantograph::Actions::DefaultPlatformAction.run(['ios'])
        expect(Pantograph::Actions.lane_context[Pantograph::Actions::SharedValues::DEFAULT_PLATFORM]).to eq(:ios)
      end

      it "raises an error if no platform is given" do
        expect do
          Pantograph::Actions::DefaultPlatformAction.run([])
        end.to raise_error("You forgot to pass the default platform")
      end

      it "works as expected inside a Pantfile" do
        Pantograph::PantFile.new.parse("lane :test do
          default_platform :ios
        end").runner.execute(:test)
        expect(Pantograph::Actions.lane_context[Pantograph::Actions::SharedValues::DEFAULT_PLATFORM]).to eq(:ios)
      end
    end
    describe "Extra platforms" do
      around(:each) do |example|
        Pantograph::SupportedPlatforms.extra = []
        example.run
        Pantograph::SupportedPlatforms.extra = []
      end
      it "displays a warning if a platform is not supported" do
        expect(PantographCore::UI).to receive(:important).with("Platform 'notSupportedOS' is not officially supported. Currently supported platforms are [:ios, :mac, :android].")
        Pantograph::Actions::DefaultPlatformAction.run(['notSupportedOS'])
      end

      it "doesn't display a warning at every run if a platform has been added to extra" do
        Pantograph::SupportedPlatforms.extra = [:notSupportedOS]
        expect(PantographCore::UI).not_to(receive(:important))
        Pantograph::Actions::DefaultPlatformAction.run(['notSupportedOS'])
      end
    end
  end
end
