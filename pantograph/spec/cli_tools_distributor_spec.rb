require 'pantograph/cli_tools_distributor'

describe Pantograph::CLIToolsDistributor do
  describe "command handling" do
    # it "runs the lane instead of the tool when there is a conflict" do
    #   PantographSpec::Env.with_ARGV(["nexus_upload"]) do
    #     require 'pantograph/commands_generator'
    #     expect(PantographCore::PantographFolder).to receive(:pantfile_path).and_return("./pantograph/spec/fixtures/pantfiles/PantfileUseToolNameAsLane").at_least(:once)
    #     expect(Pantograph::CommandsGenerator).to receive(:start).and_return(nil)
    #     Pantograph::CLIToolsDistributor.take_off
    #   end
    # end

    # it "runs a separate tool when the tool is available and the name is not used in a lane" do
    #   PantographSpec::Env.with_ARGV(["gym"]) do
    #     require 'gym/options'
    #     require 'gym/commands_generator'
    #     expect(PantographCore::PantographFolder).to receive(:pantfile_path).and_return("./pantograph/spec/fixtures/pantfiles/PantfileUseToolNameAsLane").at_least(:once)
    #     expect(Gym::CommandsGenerator).to receive(:start).and_return(nil)
    #     Pantograph::CLIToolsDistributor.take_off
    #   end
    # end
  end

  describe "update checking" do
    # it "checks for updates when running a lane" do
    #   PantographSpec::Env.with_ARGV(["builder"]) do
    #     require 'pantograph/commands_generator'
    #     expect(PantographCore::PantographFolder).to receive(:pantfile_path).and_return("./pantograph/spec/fixtures/pantfiles/PantfileUseToolNameAsLane").at_least(:once)
    #     expect(PantographCore::UpdateChecker).to receive(:start_looking_for_update).with('pantograph')
    #     expect(Pantograph::CommandsGenerator).to receive(:start).and_return(nil)
    #     expect(PantographCore::UpdateChecker).to receive(:show_update_status).with('pantograph', Pantograph::VERSION)
    #     Pantograph::CLIToolsDistributor.take_off
    #   end
    # end

    # it "checks for updates when running a tool" do
    #   PantographSpec::Env.with_ARGV(["gym"]) do
    #     require 'gym/options'
    #     require 'gym/commands_generator'
    #     expect(PantographCore::PantographFolder).to receive(:pantfile_path).and_return("./pantograph/spec/fixtures/pantfiles/PantfileUseToolNameAsLane").at_least(:once)
    #     expect(PantographCore::UpdateChecker).to receive(:start_looking_for_update).with('pantograph')
    #     expect(Gym::CommandsGenerator).to receive(:start).and_return(nil)
    #     expect(PantographCore::UpdateChecker).to receive(:show_update_status).with('pantograph', Pantograph::VERSION)
    #     Pantograph::CLIToolsDistributor.take_off
    #   end
    # end

    it "checks for updates even if the lane has an error" do
      PantographSpec::Env.with_ARGV(["beta"]) do
        expect(PantographCore::PantographFolder).to receive(:pantfile_path).and_return("./pantograph/spec/fixtures/pantfiles/PantfileErrorInError").at_least(:once)
        expect(PantographCore::UpdateChecker).to receive(:start_looking_for_update).with('pantograph')
        expect(PantographCore::UpdateChecker).to receive(:show_update_status).with('pantograph', Pantograph::VERSION)
        expect_any_instance_of(Commander::Runner).to receive(:abort).with("\n[!] Original error".red).and_raise(SystemExit) # mute console output from `abort`
        expect do
          Pantograph::CLIToolsDistributor.take_off
        end.to raise_error(SystemExit)
      end
    end
  end
end
