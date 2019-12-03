describe Pantograph do
  describe Pantograph::PantFile do
    describe "is_ci" do
      it "returns the correct value" do
        result = Pantograph::PantFile.new.parse("lane :test do
          is_ci
        end").runner.execute(:test)

        expect(result).to eq(PantographCore::Helper.ci?)
      end

      it "works with a ? in the end" do
        result = Pantograph::PantFile.new.parse("lane :test do
          is_ci?
        end").runner.execute(:test)

        expect(result).to eq(PantographCore::Helper.ci?)
      end
    end
  end
end
