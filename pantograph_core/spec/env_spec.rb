describe PantographCore do
  describe PantographCore::Env do
    describe '#disabled/unset' do
      it "Reports false on disabled env" do
        PantographSpec::Env.with_env_values('PANT_TEST_FALSE' => 'false', 'PANT_TEST_ZERO' => '0', 'PANT_TEST_OFF' => 'off', 'PANT_TEST_NO' => 'no', 'PANT_TEST_NIL' => nil) do
          expect(PantographCore::Env.truthy?('PANT_TEST_FALSE')).to be_falsey
          expect(PantographCore::Env.truthy?('PANT_TEST_ZERO')).to be_falsey
          expect(PantographCore::Env.truthy?('PANT_TEST_OFF')).to be_falsey
          expect(PantographCore::Env.truthy?('PANT_TEST_NO')).to be_falsey
          expect(PantographCore::Env.truthy?('PANT_TEST_NOTSET')).to be_falsey
          expect(PantographCore::Env.truthy?('PANT_TEST_NIL')).to be_falsey
        end
      end
      it "Reports true on enabled env" do
        PantographSpec::Env.with_env_values('PANT_TEST_SET' => '1') do
          expect(PantographCore::Env.truthy?('PANT_TEST_SET')).to be_truthy
        end
      end
    end
  end
end
