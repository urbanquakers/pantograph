describe Pantograph::Actions::GitBranchAction do
  describe "with no CI set ENV values" do
    it "gets the value from Git directly" do
      # expect(Pantograph::Actions::GitBranchAction).to receive(:`)
      #   .with(Pantograph::Helper::Git.current_branch)
      #   .and_return('branch-name')

      result = Pantograph::PantFile.new.parse("lane :test do
        git_branch
      end").runner.execute(:test)

      expect(result).to eq('git rev-parse --abbrev-ref HEAD')
    end
  end
end
