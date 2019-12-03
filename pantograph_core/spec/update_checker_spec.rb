require 'pantograph_core/update_checker/update_checker'

describe PantographCore do
  describe PantographCore::UpdateChecker do
    let(:name) { 'pantograph' }

    describe "#update_available?" do
      it "no update is available" do
        PantographCore::UpdateChecker.server_results[name] = '0.1'
        expect(PantographCore::UpdateChecker.update_available?(name, '0.9.11')).to eq(false)
      end

      it "new update is available" do
        PantographCore::UpdateChecker.server_results[name] = '999.0'
        expect(PantographCore::UpdateChecker.update_available?(name, '0.9.11')).to eq(true)
      end

      it "same version" do
        PantographCore::UpdateChecker.server_results[name] = Pantograph::VERSION
        expect(PantographCore::UpdateChecker.update_available?(name, Pantograph::VERSION)).to eq(false)
      end

      it "new pre-release" do
        PantographCore::UpdateChecker.server_results[name] = [Pantograph::VERSION, 'pre'].join(".")
        expect(PantographCore::UpdateChecker.update_available?(name, Pantograph::VERSION)).to eq(false)
      end

      it "current: Pre-Release - new official version" do
        PantographCore::UpdateChecker.server_results[name] = '0.9.1'
        expect(PantographCore::UpdateChecker.update_available?(name, '0.9.1.pre')).to eq(true)
      end

      it "a new pre-release when pre-release is installed" do
        PantographCore::UpdateChecker.server_results[name] = '0.9.1.pre2'
        expect(PantographCore::UpdateChecker.update_available?(name, '0.9.1.pre1')).to eq(true)
      end
    end

    describe "#update_command" do
      before do
        ENV.delete("BUNDLE_BIN_PATH")
        ENV.delete("BUNDLE_GEMFILE")
      end

      it "works a custom gem name" do
        expect(PantographCore::UpdateChecker.update_command(gem_name: "gym")).to eq("gem install gym")
      end

      it "works with system ruby" do
        expect(PantographCore::UpdateChecker.update_command).to eq("gem install pantograph")
      end

      it "works with bundler" do
        PantographSpec::Env.with_env_values('BUNDLE_BIN_PATH' => '/tmp') do
          expect(PantographCore::UpdateChecker.update_command).to eq("bundle update pantograph")
        end
      end

      it "works with bundled pantograph" do
        PantographSpec::Env.with_env_values('PANTOGRAPH_SELF_CONTAINED' => 'true') do
          expect(PantographCore::UpdateChecker.update_command).to eq("pantograph update_pantograph")
        end
      end
    end
  end
end
