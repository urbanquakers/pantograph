describe Pantograph do
  describe Pantograph::PantFile do
    describe "Git Pull Action" do
      it "runs git pull and git fetch with tags by default" do
        result = Pantograph::PantFile.new.parse("lane :test do
            git_pull
          end").runner.execute(:test)

        expect(result).to eq("git pull && git fetch --tags")
      end

      it "only runs git fetch --tags if only_tags" do
        result = Pantograph::PantFile.new.parse("lane :test do
            git_pull(
              only_tags: true
            )
          end").runner.execute(:test)

        expect(result).to eq("git fetch --tags")
      end
    end
  end
end
