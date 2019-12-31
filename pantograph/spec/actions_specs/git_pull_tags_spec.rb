describe Pantograph do
  describe Pantograph::PantFile do
    describe "Git Pull Tags Action" do
      it "runs git pull tags" do
        result = Pantograph::PantFile.new.parse("lane :test do
            git_pull_tags
          end").runner.execute(:test)

        expect(result).to eq("git fetch --tags")
      end
    end
  end
end
