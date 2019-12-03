describe Pantograph do
  describe Pantograph::PantFile do
    describe "Public/Private lanes" do
      let(:path) { './pantograph/spec/fixtures/pantfiles/PantfilePrivatePublic' }
      before do
        FileUtils.rm_rf('/tmp/pantograph/')

        @ff = Pantograph::PantFile.new(path)
      end

      it "raise an exception when calling a private lane" do
        expect do
          @ff.runner.execute('private_helper')
        end.to raise_error("You can't call the private lane 'private_helper' directly")
      end

      it "still supports calling public lanes" do
        result = @ff.runner.execute('public')
        expect(result).to eq("publicResult")
      end

      it "supports calling private lanes from public lanes" do
        result = @ff.runner.execute('smooth')
        expect(result).to eq("success")
      end

      it "doesn't expose the private lanes in `pantograph lanes`" do
        require 'pantograph/lane_list'
        result = Pantograph::LaneList.generate(path)
        expect(result).to include("such smooth")
        expect(result).to_not(include("private call"))
      end

      it "doesn't expose the private lanes in `pantograph docs`" do
        output_path = "/tmp/documentation.md"
        ff = Pantograph::PantFile.new(path)
        Pantograph::DocsGenerator.run(ff, output_path)
        output = File.read(output_path)

        expect(output).to include('gem install pantograph')
        expect(output).to include('such smooth')
        expect(output).to_not(include('private'))
      end
    end
  end
end
