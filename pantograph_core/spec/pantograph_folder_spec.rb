describe PantographCore::PantographFolder do
  let(:pantfile_name) { "Pantfile" }
  describe "#path" do
    it "returns the pantograph path if it exists" do
      expect(PantographCore::PantographFolder.path).to eq("./pantograph/")
    end

    it "returns nil if the pantograph path isn't available" do
      Dir.chdir("/") do
        expect(PantographCore::PantographFolder.path).to eq(nil)
      end
    end

    it "returns the path if pantograph is being executed from the pantograph directory" do
      Dir.chdir("pantograph") do
        expect(PantographCore::PantographFolder.path).to eq('./')
      end
    end
  end

  describe "#pantfile_path" do
    it "uses a Pantfile that's inside a pantograph directory" do
      expect(PantographCore::PantographFolder.pantfile_path).to eq(File.join(".", "pantograph", pantfile_name))
    end

    it "uses a Pantfile that's inside a pantograph directory if cd is inside a pantograph dir" do
      Dir.chdir("pantograph") do
        expect(PantographCore::PantographFolder.pantfile_path).to eq(File.join(".", pantfile_name))
      end
    end

    it "doesn't try to use a Pantfile if it's not inside a pantograph folder" do
      Dir.chdir("bin") do
        File.write(pantfile_name, "")
        begin
          expect(PantographCore::PantographFolder.pantfile_path).to eq(nil)
        rescue RSpec::Expectations::ExpectationNotMetError => ex
          raise ex
        ensure
          File.delete(pantfile_name)
        end
      end
    end
  end
end
