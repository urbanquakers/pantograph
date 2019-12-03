describe Pantograph do
  describe Pantograph::PantFile do
    describe "git_commit" do
      before :each do
        allow(PantographCore::PantographFolder).to receive(:path).and_return(nil)
      end

      it "generates the correct git command" do
        result = Pantograph::PantFile.new.parse("lane :test do
          git_commit(path: './pantograph/README.md', message: 'message')
        end").runner.execute(:test)

        expect(result).to eq("git commit -m message ./pantograph/README.md")
      end

      it "generates the correct git command with an array of paths" do
        result = Pantograph::PantFile.new.parse("lane :test do
          git_commit(path: ['./pantograph/README.md', './LICENSE'], message: 'message')
        end").runner.execute(:test)

        expect(result).to eq("git commit -m message ./pantograph/README.md ./LICENSE")
      end

      it "generates the correct git command with an array of paths and/or pathspecs" do
        result = Pantograph::PantFile.new.parse("lane :test do
          git_commit(path: ['./pantograph/*.md', './LICENSE'], message: 'message')
        end").runner.execute(:test)

        expect(result).to eq("git commit -m message #{'./pantograph/*.md'.shellescape} ./LICENSE")
      end

      it "generates the correct git command with shell-escaped-paths" do
        result = Pantograph::PantFile.new.parse("lane :test do
          git_commit(path: ['./pantograph/README.md', './LICENSE', './pantograph/spec/fixtures/git_commit/A FILE WITH SPACE'], message: 'message')
        end").runner.execute(:test)

        expect(result).to eq("git commit -m message ./pantograph/README.md ./LICENSE " + "./pantograph/spec/fixtures/git_commit/A FILE WITH SPACE".shellescape)
      end

      it "generates the correct git command with a shell-escaped message" do
        message = "message with 'quotes' (and parens)"
        result = Pantograph::PantFile.new.parse("lane :test do
          git_commit(path: './pantograph/README.md', message: \"#{message}\")
        end").runner.execute(:test)
        expect(result).to eq("git commit -m #{message.shellescape} ./pantograph/README.md")
      end

      it "generates the correct git command when configured to skip git hooks" do
        result = Pantograph::PantFile.new.parse("lane :test do
          git_commit(path: './pantograph/README.md', message: 'message', skip_git_hooks: true)
        end").runner.execute(:test)

        expect(result).to eq("git commit -m message ./pantograph/README.md --no-verify")
      end

      it "generates the correct git command when configured to allow nothing to commit and there are changes to commit" do
        result = Pantograph::PantFile.new.parse("lane :test do
          git_commit(path: './pantograph/README.md', message: 'message', allow_nothing_to_commit: true)
        end").runner.execute(:test)

        expect(result).to eq("git commit -m message ./pantograph/README.md")
      end

      it "does not generate the git command when configured to allow nothing to commit and there are no changes to commit" do
        allow(Pantograph::Actions).to receive(:sh)
          .with("git status --porcelain")
          .and_return("")
        result = Pantograph::PantFile.new.parse("lane :test do
          git_commit(path: './pantograph/README.md', message: 'message', allow_nothing_to_commit: true)
        end").runner.execute(:test)

        expect(result).to be_nil
      end
    end
  end
end
