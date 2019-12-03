require "pantograph/environment_printer"
require "pantograph/cli_tools_distributor"

describe Pantograph do
  describe Pantograph::EnvironmentPrinter do
    before do
      stub_request(:get, %r{https:\/\/rubygems.org\/api\/v1\/gems\/.*}).
        to_return(status: 200, body: '{"version": "0.16.2"}', headers: {})
    end

    let(:pantograph_files) { Pantograph::EnvironmentPrinter.print_pantograph_files }
    it "contains the key words" do
      expect(pantograph_files).to include("pantograph files")
      expect(pantograph_files).to include("Pantfile")
      # expect(pantograph_files).to include("Appfile")
    end

    let(:env) { Pantograph::EnvironmentPrinter.get }

    it "contains the key words" do
      expect(env).to include("pantograph gems")
      expect(env).to include("generated on")
    end

    it "prints out the loaded pantograph plugins" do
      expect(env).to include("Loaded pantograph plugins")
    end

    it "prints out the loaded gem dependencies" do
      expect(env).to include("Loaded gems")
      expect(env).to include("addressable")
      expect(env).to include("xcpretty")
    end

    it "contains main information about the stack", requires_xcode: true do
      expect(env).to include("Bundler?")
      expect(env).to include("Xcode Path")
      expect(env).to include("Xcode Version")
      expect(env).to include("OpenSSL")
    end

    it "anonymizes a path containing the user’s home" do
      expect(Pantograph::EnvironmentPrinter.anonymized_path('/Users/john/.pantograph/bin/bundle/bin/pantograph', '/Users/john')).to eq('~/.pantograph/bin/bundle/bin/pantograph')
      expect(Pantograph::EnvironmentPrinter.anonymized_path('/Users/john', '/Users/john')).to eq('~')
      expect(Pantograph::EnvironmentPrinter.anonymized_path('/Users/john/', '/Users/john')).to eq('~/')
      expect(Pantograph::EnvironmentPrinter.anonymized_path('/workspace/project/test', '/work')).to eq('/workspace/project/test')
    end

    # context 'PantographCore::Helper.xcode_version cannot be obtained' do
    #   before do
    #     allow(PantographCore::Helper).to receive(:xcode_version).and_raise("Boom!")
    #   end

    #   it 'contains stack information other than Xcode Version', requires_xcode: true do
    #     expect(env).to include("Bundler?")
    #     expect(env).to include("Xcode Path")
    #     expect(env).not_to(include("Xcode Version"))
    #     expect(env).to include("OpenSSL")
    #   end
    # end
  end
end
