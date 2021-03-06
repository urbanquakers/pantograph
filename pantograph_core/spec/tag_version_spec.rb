describe PantographCore::TagVersion do
  describe "version_number_from_tag" do
    # This is the style generated by rake release.
    it "removes any initial v" do
      tag = "v0.1.0-beta.3"
      version_number = PantographCore::TagVersion.version_number_from_tag(tag)
      expect(version_number).to eq("0.1.0-beta.3")
    end

    it "returns any tag that does not start with v" do
      tag = "0.1.0-beta.3"
      version_number = PantographCore::TagVersion.version_number_from_tag(tag)
      expect(version_number).to eq("0.1.0-beta.3")
    end
  end

  describe "correct?" do
    it "returns true for versions supported by Gem::Version" do
      tag = "1.2.3"
      expect(PantographCore::TagVersion.correct?(tag)).to be(true)
    end

    it "returns true for tags that can be converted to a Gem::Version using version_number_from_tag" do
      tag = "v1.2.3"
      expect(PantographCore::TagVersion.correct?(tag)).to be(true)
    end

    it "returns false for tags that are not versions" do
      tag = "finished-refactoring"
      expect(PantographCore::TagVersion.correct?(tag)).to be(false)
    end
  end

  context "initialization" do
    it "accepts tags starting with v" do
      version = PantographCore::TagVersion.new("v1.2.3.4.5")
      gem_version = Gem::Version.new("1.2.3.4.5")
      expect(version).to eq(gem_version)
    end

    it "accepts versions accepted by Gem::Version" do
      version = PantographCore::TagVersion.new("1.2.3.4.5")
      gem_version = Gem::Version.new("1.2.3.4.5")
      expect(version).to eq(gem_version)
    end
  end
end
