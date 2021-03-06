describe Pantograph do
  describe Pantograph::PantFile do
    before do
      allow(PantographCore::PantographFolder).to receive(:path).and_return(nil)
      @path = "./pantograph/spec/fixtures/actions/archive.rb"
      @output_path_with_zip = "./pantograph/spec/fixtures/actions/archive_file.zip"
      @output_path_without_zip = "./pantograph/spec/fixtures/actions/archive_file"
    end

    describe "zip" do
      it "generates a valid zip command" do
        expect(Pantograph::Actions).to receive(:sh).with("zip -r #{File.expand_path(@path)}.zip archive.rb")

        result = Pantograph::PantFile.new.parse("lane :test do
          zip(path: '#{@path}')
        end").runner.execute(:test)
      end

      it "generates a valid zip command without verbose output" do
        expect(Pantograph::Actions).to receive(:sh).with("zip -rq #{File.expand_path(@path)}.zip archive.rb")

        result = Pantograph::PantFile.new.parse("lane :test do
          zip(path: '#{@path}', verbose: false)
        end").runner.execute(:test)
      end

      it "generates an output path given no output path" do
        result = Pantograph::PantFile.new.parse("lane :test do
          zip(path: '#{@path}', output_path: '#{@path}')
        end").runner.execute(:test)

        expect(result).to eq(File.absolute_path("#{@path}.zip"))
      end

      it "generates an output path with zip extension (given zip extension)" do
        result = Pantograph::PantFile.new.parse("lane :test do
          zip(path: '#{@path}', output_path: '#{@output_path_with_zip}')
        end").runner.execute(:test)

        expect(result).to eq(File.absolute_path(@output_path_with_zip))
      end

      it "generates an output path with zip extension (not given zip extension)" do
        result = Pantograph::PantFile.new.parse("lane :test do
          zip(path: '#{@path}', output_path: '#{@output_path_without_zip}')
        end").runner.execute(:test)

        expect(result).to eq(File.absolute_path(@output_path_with_zip))
      end

      it "encrypts the contents of the zip archive using a password" do
        password = "5O#RUKp0Zgop"
        expect(Pantograph::Actions).to receive(:sh).with("zip -rq -P '#{password}' #{File.expand_path(@path)}.zip archive.rb")

        result = Pantograph::PantFile.new.parse("lane :test do
          zip(path: '#{@path}', verbose: false, password: '#{password}')
        end").runner.execute(:test)
      end
    end
  end
end
