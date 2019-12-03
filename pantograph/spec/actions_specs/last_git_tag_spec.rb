describe Pantograph do
  describe Pantograph::PantFile do
    describe "last_git_tag" do
      it "Returns the last git tag" do
        result = Pantograph::PantFile.new.parse("lane :test do
          last_git_tag
        end").runner.execute(:test)

        tag_name = %w(git rev-list --tags --max-count=1).shelljoin
        describe = %W(git describe --tags #{tag_name}).shelljoin
        expect(result).to eq(describe)
      end
    end
  end
end
