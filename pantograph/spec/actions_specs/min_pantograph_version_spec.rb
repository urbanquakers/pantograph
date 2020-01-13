describe Pantograph do
  describe Pantograph::PantFile do
    describe "min_pantograph_version action" do
      it "works as expected" do
        Pantograph::PantFile.new.parse("lane :test do
          min_pantograph_version '0.1'
        end").runner.execute(:test)
      end

      it "raises an exception if it's an old version" do
        expect do
          stub_const('ENV', { 'BUNDLE_BIN_PATH' => '/fake/elsewhere' })
          expect(PantographCore::Changelog).to receive(:show_changes).with("pantograph", Pantograph::VERSION, update_gem_command: "bundle update pantograph")
          Pantograph::PantFile.new.parse("lane :test do
            min_pantograph_version '9999'
          end").runner.execute(:test)
        end.to raise_error(/The Pantfile requires a pantograph version of >= 9999./)
      end

      it "raises an exception if it's an old version in a non-bundler environement" do
        expect do
          # We have to clean ENV to be sure that Bundler environement is not defined.
          stub_const('ENV', {})
          expect(PantographCore::Changelog).to receive(:show_changes).with("pantograph", Pantograph::VERSION, update_gem_command: "gem install pantograph")

          Pantograph::PantFile.new.parse("lane :test do
            min_pantograph_version '9999'
          end").runner.execute(:test)
        end.to raise_error("The Pantfile requires a pantograph version of >= 9999. You are on #{Pantograph::VERSION}.")
      end

      it "raises an exception if it's an old version in a bundler environement" do
        expect do
          expect(PantographCore::Changelog).to receive(:show_changes).with("pantograph", Pantograph::VERSION, update_gem_command: "bundle update pantograph")

          # Let's define BUNDLE_BIN_PATH in ENV to simulate a bundler environement
          stub_const('ENV', { 'BUNDLE_BIN_PATH' => '/fake/elsewhere' })
          Pantograph::PantFile.new.parse("lane :test do
            min_pantograph_version '9999'
          end").runner.execute(:test)
        end.to raise_error("The Pantfile requires a pantograph version of >= 9999. You are on #{Pantograph::VERSION}.")
      end

      it "raises an error if no pantograph version is given" do
        expect do
          Pantograph::PantFile.new.parse("lane :test do
            min_pantograph_version
          end").runner.execute(:test)
        end.to raise_error('Please provide minimum pantograph version')
      end
    end
  end
end
