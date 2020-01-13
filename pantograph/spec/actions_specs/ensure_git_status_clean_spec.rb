describe Pantograph do
  describe Pantograph::PantFile do
    describe "ensure_git_status_clean" do
      before :each do
        allow(PantographCore::PantographFolder).to receive(:path).and_return(nil)
        allow(PantographCore::UI).to receive(:success).with("Driving the lane 'test' 🚀")
      end

      context "when git status is clean" do
        before :each do
          allow(Pantograph::Actions).to receive(:sh).with("git status --porcelain").and_return("")
        end

        it "outputs success message" do
          expect(PantographCore::UI).to receive(:success).with("Git status is clean, all good! 💪")
          Pantograph::PantFile.new.parse("lane :test do
            ensure_git_status_clean
          end").runner.execute(:test)
        end
      end

      context "when git status is not clean" do
        before :each do
          allow(Pantograph::Actions).to receive(:sh).with("git status --porcelain").and_return("M pantograph/lib/pantograph/actions/ensure_git_status_clean.rb")
        end

        context "with show_uncommitted_changes flag" do
          context "true" do
            it "outputs reach error message" do
              expect(PantographCore::UI).to receive(:user_error!).with("Git repository is dirty! Please ensure the repo is in a clean state by committing/stashing/discarding all changes first.\nUncommitted changes:\nM pantograph/lib/pantograph/actions/ensure_git_status_clean.rb")
              Pantograph::PantFile.new.parse("lane :test do
                ensure_git_status_clean
              end").runner.execute(:test)
            end
          end
        end
      end
    end
  end
end
