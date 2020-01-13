describe Pantograph do
  describe Pantograph::PantFile do
    describe 'ensure_env_vars' do
      context 'when param is valid' do
        before :each do
          allow(PantographCore::UI).to receive(:success).with('Driving the lane \'test\' 🚀')
        end

        context 'and env var is set' do
          before :each do
            allow(ENV).to receive(:[]).and_return('valid')
            ENV['FIRST'] = 'true'
          end

          it 'outputs success message' do
            expect(PantographCore::UI).to receive(:success).with('ENV variable(s) \'FIRST\' set!')

            Pantograph::PantFile.new.parse('lane :test do
              ensure_env_vars(vars: [\'FIRST\'])
            end').runner.execute(:test)
          end
        end

        context 'and env vars are set' do
          before :each do
            allow(ENV).to receive(:[]).and_return('valid')
            ENV['FIRST']  = 'true'
            ENV['SECOND'] = 'true'
          end

          it 'outputs success message' do
            expect(PantographCore::UI).to receive(:success).with('ENV variable(s) \'FIRST\', \'SECOND\' set!')

            Pantograph::PantFile.new.parse('lane :test do
              ensure_env_vars(vars: [\'FIRST\', \'SECOND\'])
            end').runner.execute(:test)
          end
        end

        context 'and env var is not set' do
          it 'outputs error message' do
            expect do
              Pantograph::PantFile.new.parse('lane :test do
                ensure_env_vars(vars: [\'MISSING\'])
              end').runner.execute(:test)
            end.to raise_error(PantographCore::Interface::PantographError) do |error|
              expect(error.message).to eq("Unable to find ENV Variable(s):\nMISSING")
            end
          end
        end

        context 'and env var is empty' do
          before :each do
            allow(ENV).to receive(:[]).and_return(' ')
          end

          it 'outputs error message' do
            expect do
              Pantograph::PantFile.new.parse('lane :test do
                ensure_env_vars(vars: [\'MISSING\'])
              end').runner.execute(:test)
            end.to raise_error(PantographCore::Interface::PantographError) do |error|
              expect(error.message).to eq("Unable to find ENV Variable(s):\nMISSING")
            end
          end
        end
      end

      context 'when param is not valid' do
        context 'because no env var is passed' do
          it 'outputs error message' do
            expect do
              Pantograph::PantFile.new.parse('lane :test do
                ensure_env_vars(vars: [])
              end').runner.execute(:test)
            end.to raise_error(PantographCore::Interface::PantographError) do |error|
              expect(error.message).to eq('Specify at least one environment variable key')
            end
          end
        end
      end
    end
  end
end
