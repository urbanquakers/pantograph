require 'pantograph/documentation/docs_generator'

describe Pantograph do
  describe Pantograph::DocsGenerator do
    it "generates new markdown docs" do
      output_path = "/tmp/documentation.md"
      ff = Pantograph::PantFile.new('./pantograph/spec/fixtures/pantfiles/PantfileGrouped')
      Pantograph::DocsGenerator.run(ff, output_path)

      output = File.read(output_path)

      expect(output).to include('gem install pantograph')
      expect(output).to include('# Available Actions')
      expect(output).to include('### test')
      expect(output).to include('# MacOS')
      expect(output).to include('pantograph test')
      expect(output).to include('## mac')
      expect(output).to include('----')
      expect(output).to include('Upload something to Google')
      expect(output).to include('pantograph mac beta')
      expect(output).to include('https://pantograph.tools')
    end

    it "generates new markdown docs but skips empty platforms" do
      output_path = "/tmp/documentation.md"
      ff = Pantograph::PantFile.new('./pantograph/spec/fixtures/pantfiles/PantfilePlatformDocumentation')
      Pantograph::DocsGenerator.run(ff, output_path)

      output = File.read(output_path)

      expect(output).to include('gem install pantograph')
      expect(output).to include('# Available Actions')
      expect(output).to include('## Linux')
      expect(output).to include('### linux lane')
      expect(output).to include('pantograph linux lane')
      expect(output).to include("I'm a lane")

      expect(output).not_to(include('## iOS'))
      expect(output).not_to(include('## Mac'))
      expect(output).not_to(include('mac_lane'))
      expect(output).not_to(include("I'm a mac private_lane"))
    end
  end
end
