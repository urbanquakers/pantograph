describe Pantograph::PluginUpdateManager do
  describe "#show_update_status" do
    before(:each) do
      ENV.delete("PANTOGRAPH_SKIP_UPDATE_CHECK")
    end

    it "does nothing if no updates are available" do
      Pantograph::PluginUpdateManager.show_update_status
    end

    it "prints out a table if updates are available" do
      plugin_name = 'something'
      Pantograph::PluginUpdateManager.server_results[plugin_name] = Gem::Version.new('1.1.0')
      allow(Pantograph::PluginUpdateManager).to receive(:plugin_references).and_return({
        plugin_name => {
          version_number: "0.1.1"
        }
      })

      rows = [["something", "0.1.1".red, "1.1.0".green]]
      headings = ["Plugin", "Your Version", "Latest Version"]
      expect(Terminal::Table).to receive(:new).with(title: "Plugin updates available".yellow,
                                                 headings: headings,
                                                     rows: rows)

      Pantograph::PluginUpdateManager.show_update_status
    end
  end
end
