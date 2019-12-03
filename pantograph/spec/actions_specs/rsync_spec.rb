describe Pantograph do
  describe Pantograph::PantFile do
    describe "rsync" do
      it "generates a valid command" do
        result = Pantograph::PantFile.new.parse("lane :test do
          rsync(source: '/tmp/1.txt', destination: '/tmp/2.txt')
        end").runner.execute(:test)
        expect(result).to eq("rsync -av /tmp/1.txt /tmp/2.txt")
      end
    end
  end
end
