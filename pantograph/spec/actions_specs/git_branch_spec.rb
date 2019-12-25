describe Pantograph::Actions::GitBranchAction do
  describe "with no CI set ENV values" do
    it "gets the value from Git directly" do
      expect(Pantograph::Actions::GitBranchAction).to receive(:`)
        .with('git symbolic-ref HEAD --short 2>/dev/null')
        .and_return('branch-name')

      result = Pantograph::PantFile.new.parse("lane :test do
        git_branch
      end").runner.execute(:test)

      expect(result).to eq("branch-name")
    end
  end
end
