describe Pantograph do
  describe Pantograph::PantFile do
    describe "CLOC Integration" do
      it "does run cloc using only default options" do
        result = Pantograph::PantFile.new.parse("lane :test do
            cloc
          end").runner.execute(:test)

        expect(result).to eq("/usr/local/bin/cloc . --by-file --yaml --report-file=pantograph/reports/cloc.yaml")
      end

      it 'does set the exclude directories' do
        result = Pantograph::PantFile.new.parse("lane :test do
            cloc(exclude_dir: 'test1,test2,build')
          end").runner.execute(:test)

        expect(result).to eq("/usr/local/bin/cloc . --exclude-dir=test1,test2,build --by-file --yaml --report-file=pantograph/reports/cloc.yaml")
      end

      it 'does set the output directory' do
        result = Pantograph::PantFile.new.parse("lane :test do
            cloc(output_directory: '/tmp')
          end").runner.execute(:test)

        expect(result).to eq("/usr/local/bin/cloc . --by-file --yaml --report-file=/tmp/cloc.yaml")
      end

      it 'does set the source directory' do
        result = Pantograph::PantFile.new.parse("lane :test do
            cloc(source_directory: 'MyApp')
          end").runner.execute(:test)

        expect(result).to eq("/usr/local/bin/cloc MyApp --by-file --yaml --report-file=pantograph/reports/cloc.yaml")
      end

      it 'does switch to xml when output_type is set to xml' do
        result = Pantograph::PantFile.new.parse("lane :test do
            cloc(output_type: 'xml')
          end").runner.execute(:test)

        expect(result).to eq("/usr/local/bin/cloc . --by-file --xml --report-file=pantograph/reports/cloc.xml")
      end
    end
  end
end
