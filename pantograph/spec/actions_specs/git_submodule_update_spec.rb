describe Pantograph do
  describe Pantograph::PantFile do
    describe "git_submodule_update" do
      it "runs git submodule update without options by default" do
        result = Pantograph::PantFile.new.parse("lane :test do
            git_submodule_update
          end").runner.execute(:test)

        expect(result).to eq("git submodule update")
      end

      it "updates the submodules recursively if requested" do
        result = Pantograph::PantFile.new.parse("lane :test do
            git_submodule_update(
              recursive: true
            )
          end").runner.execute(:test)

        expect(result).to eq("git submodule update --recursive")
      end

      it "initialize the submodules if requested" do
        result = Pantograph::PantFile.new.parse("lane :test do
            git_submodule_update(
              init: true
            )
          end").runner.execute(:test)

        expect(result).to eq("git submodule update --init")
      end

      it "initialize the submodules and updates them recursively if requested" do
        result = Pantograph::PantFile.new.parse("lane :test do
            git_submodule_update(
              recursive: true,
              init: true
            )
          end").runner.execute(:test)

        expect(result).to eq("git submodule update --init --recursive")
      end
    end
  end
end
