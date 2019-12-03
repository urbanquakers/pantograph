describe Pantograph::ActionCollector do
  before(:all) { ENV.delete("PANTOGRAPH_OPT_OUT_USAGE") }

  let(:collector) { Pantograph::ActionCollector.new }

  describe "#determine_version" do
    it "accesses the version number of the other tools" do
      expect(collector.determine_version(:gym)).to eq(Pantograph::VERSION)
      expect(collector.determine_version(:sigh)).to eq(Pantograph::VERSION)
    end

    it "fetches the version of the plugin, if action is part of a plugin" do
      module Pantograph::MyPlugin
        VERSION = '1.2.3'
      end

      expect(collector.determine_version("pantograph-plugin-my_plugin/xcversion")).to eq('1.2.3')
    end

    it "returns 'undefined' if plugin version information is not available" do
      expect(collector.determine_version("pantograph-plugin-not-existent/action_name")).to eq('undefined')
    end

    it "falls back to the pantograph version number" do
      expect(collector.determine_version(:pantograph)).to eq(Pantograph::VERSION)
      expect(collector.determine_version(:xcode_install)).to eq(Pantograph::VERSION)
    end
  end
end
