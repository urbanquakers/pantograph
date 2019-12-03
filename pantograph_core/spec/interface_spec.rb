describe PantographCore::Interface do
  describe "Abort helper methods" do
    describe "#abort_with_message!" do
      it "raises PantographCommonException" do
        expect do
          PantographCore::Interface.new.abort_with_message!("Yup")
        end.to raise_error(PantographCore::Interface::PantographCommonException, "Yup")
      end
    end
  end
end
