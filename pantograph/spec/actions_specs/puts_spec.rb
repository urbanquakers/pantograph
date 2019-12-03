describe Pantograph do
  describe Pantograph::PantFile do
    describe "puts" do
      it "works" do
        Pantograph::PantFile.new.parse("lane :test do
          puts 'hi'
        end").runner.execute(:test)
      end
    end
  end
end
