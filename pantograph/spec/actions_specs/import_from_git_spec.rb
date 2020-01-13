describe Pantograph do
  describe Pantograph::PantFile do
    describe "import_from_git" do
      it "raises an exception when no path is given" do
        expect do
          Pantograph::PantFile.new.parse("lane :test do
            import_from_git
          end").runner.execute(:test)
        end.to raise_error("Please pass the git url to the `import_from_git` action")
      end
    end
  end
end
