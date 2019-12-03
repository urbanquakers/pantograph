describe Pantograph do
  describe Pantograph::PantFile do
    describe "push_git_tags" do
      it "uses the correct default comand" do
        result = Pantograph::PantFile.new.parse("lane :test do
          push_git_tags
        end").runner.execute(:test)

        expect(result).to eq("git push origin --tags")
      end

      it "uses the correct comand when forced" do
        result = Pantograph::PantFile.new.parse("lane :test do
          push_git_tags(force: true)
        end").runner.execute(:test)

        expect(result).to eq("git push origin --tags --force")
      end

      it "uses the correct comand when remote set" do
        result = Pantograph::PantFile.new.parse("lane :test do
          push_git_tags(remote: 'foo')
        end").runner.execute(:test)

        expect(result).to eq("git push foo --tags")
      end

      it "uses the correct comand when remote set and forced" do
        result = Pantograph::PantFile.new.parse("lane :test do
          push_git_tags(remote: 'foo', force: true)
        end").runner.execute(:test)

        expect(result).to eq("git push foo --tags --force")
      end

      it "uses the correct command when tag set" do
        result = Pantograph::PantFile.new.parse("lane :test do
          push_git_tags(remote: 'foo', tag: 'v1.0')
        end").runner.execute(:test)

        expect(result).to eq("git push foo refs/tags/v1.0")
      end
    end
  end
end
