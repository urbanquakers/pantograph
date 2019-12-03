describe Pantograph do
  describe Pantograph::PantFile do
    describe "Opt Out Usage" do
      it "works as expected" do
        Pantograph::PantFile.new.parse("lane :test do
          opt_out_usage
        end").runner.execute(:test)
        expect(ENV['PANTOGRAPH_OPT_OUT_USAGE']).to eq("YES")
      end
    end
  end
end
