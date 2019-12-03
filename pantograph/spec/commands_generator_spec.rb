require 'pantograph/commands_generator'

describe Pantograph::CommandsGenerator do
  before(:each) do
    ENV['DOTENV'] = nil
    pantograph_folder = File.absolute_path('./pantograph/spec/fixtures/dotenvs/withPantfiles/parentonly/pantograph')
    allow(PantographCore::PantographFolder).to receive(:path).and_return(pantograph_folder)
  end

  describe ":trigger option handling" do
    it "can use the env flag from tool options" do
      stub_commander_runner_args(['command_test', '--env', 'DOTENV'])
      Pantograph::CommandsGenerator.start

      expect(ENV['DOTENV']).to eq('parent')
    end
  end

  describe ":list option handling" do
    it "cannot use the env flag from tool options" do
      stub_commander_runner_args(['list', '--env', 'DOTENV'])
      expect do
        Pantograph::CommandsGenerator.start
      end.to raise_exception(OptionParser::InvalidOption, 'invalid option: --env')

      expect(ENV['DOTENV']).to be_nil
    end
  end
end
