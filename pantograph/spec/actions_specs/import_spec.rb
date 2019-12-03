describe Pantograph do
  describe Pantograph::PantFile do
    describe "import" do
      it "allows the user to import a separate Pantfile" do
        ff = Pantograph::PantFile.new('./pantograph/spec/fixtures/pantfiles/ImportPantfile')

        expect(ff.runner.execute(:main_lane)).to eq('such main') # from the original Pantfile
        expect(ff.runner.execute(:extended, :ios)).to eq('extended') # from the original Pantfile
        expect(ff.runner.execute(:test)).to eq(1) # fro the imported Pantfile

        # This should not raise an exception
      end

      it "overwrites existing lanes" do
        ff = Pantograph::PantFile.new('./pantograph/spec/fixtures/pantfiles/ImportPantfile')

        expect(ff.runner.execute(:empty, :ios)).to eq("Overwrite")
      end

      it "raises an exception when no path is given" do
        expect do
          Pantograph::PantFile.new.parse("lane :test do
            import
          end").runner.execute(:test)
        end.to raise_error("Please pass a path to the `import` action")
      end

      it "raises an exception when the given path is invalid (absolute)" do
        path = "/tmp/asdf#{Time.now.to_i}"
        expect do
          Pantograph::PantFile.new.parse("lane :test do
            import('#{path}')
          end").runner.execute(:test)
        end.to raise_error("Could not find Pantfile at path '#{path}'")
      end

      it "raises an exception when the given path is invalid (relative)" do
        expect do
          Pantograph::PantFile.new.parse("lane :test do
            import('tmp/asdf')
          end").runner.execute(:test)
        end.to raise_error(%r{Could not find Pantfile at path \'([A-Z]\:)?\/.+}) # /home (travis) # /Users (Mac) # C:/path (Windows)
      end
    end
  end
end
