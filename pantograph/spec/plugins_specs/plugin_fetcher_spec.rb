describe Pantograph do
  describe Pantograph::PluginFetcher do
    describe "#fetch_gems" do
      before do
        current_gem = "yolo"
        # We have to stub both a specific search, and the general listing
        stub_request(:get, "https://rubygems.org/api/v1/search.json?page=1&query=pantograph-plugin-#{current_gem}").
          to_return(status: 200, body: File.read("./pantograph/spec/fixtures/requests/rubygems_plugin_query.json"), headers: {})

        stub_request(:get, "https://rubygems.org/api/v1/search.json?page=2&query=pantograph-plugin-#{current_gem}").
          to_return(status: 200, body: [].to_json, headers: {})

        stub_request(:get, "https://rubygems.org/api/v1/search.json?page=1&query=pantograph-plugin-").
          to_return(status: 200, body: File.read("./pantograph/spec/fixtures/requests/rubygems_plugin_query.json"), headers: {})

        stub_request(:get, "https://rubygems.org/api/v1/search.json?page=2&query=pantograph-plugin-").
          to_return(status: 200, body: [].to_json, headers: {})
      end

      it "returns all available plugins if no search query is given" do
        plugins = Pantograph::PluginFetcher.fetch_gems
        expect(plugins.count).to eq(2)
        plugin1 = plugins.first
        expect(plugin1.full_name).to eq("pantograph-plugin-apprepo")
        expect(plugin1.name).to eq("apprepo")
        expect(plugin1.homepage).to eq("https://github.com/suculent/pantograph-plugin-apprepo")
        expect(plugin1.downloads).to eq(113)
        expect(plugin1.info).to eq("experimental pantograph plugin")
      end

      it "returns a filtered set of plugins when a search query is passed" do
        plugins = Pantograph::PluginFetcher.fetch_gems(search_query: "yolo")
        expect(plugins.count).to eq(1)
        expect(plugins.last.name).to eq("yolokit")
      end
    end
  end
end
