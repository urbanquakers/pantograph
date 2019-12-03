describe PantographCore do
  describe PantographCore::Languages do
    it "all languages are available" do
      expect(PantographCore::Languages::ALL_LANGUAGES.count).to be >= 27
    end
  end
end
