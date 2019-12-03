describe Pantograph do
  describe Pantograph::PantFile do
    describe "bundle install action" do
      it "default use case" do
        expect(Pantograph::Actions::BundleInstallAction).to receive(:gemfile_exists?).and_return(true)

        result = Pantograph::PantFile.new.parse("lane :test do
          bundle_install
        end").runner.execute(:test)

        expect(result).to eq("bundle install")
      end
    end
  end
end
