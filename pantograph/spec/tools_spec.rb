describe Pantograph do
  describe "Pantograph::TOOLS" do
    it "lists all the pantograph tools" do
      expect(Pantograph::TOOLS.count).to be >= 1
    end

    it "contains symbols for each of the tools" do
      Pantograph::TOOLS.each do |current|
        expect(current).to be_kind_of(Symbol)
      end
    end

    # it "warns the user when a lane is called like a tool" do
    #   ff = Pantograph::PantFile.new('./pantograph/spec/fixtures/pantfiles/Pantfile1')
    #   expect(UI).to receive(:error).with("------------------------------------------------")
    #   expect(UI).to receive(:error).with("Lane name 'gym' should not be used because it is the name of a pantograph tool")
    #   expect(UI).to receive(:error).with("It is recommended to not use 'gym' as the name of your lane")
    #   expect(UI).to receive(:error).with("------------------------------------------------")
    #   ff.lane(:gym) do
    #   end
    # end
  end
end
