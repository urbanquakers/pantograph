require 'pantograph/pantograph_require'

describe Pantograph do
  describe Pantograph::PantographRequire do
    it "formats gem require name for pantograph-plugin" do
      gem_name = "pantograph-plugin-test"
      gem_require_name = Pantograph::PantographRequire.format_gem_require_name(gem_name)
      expect(gem_require_name).to eq("pantograph/plugin/test")
    end

    it "formats gem require name for non-pantograph-plugin" do
      gem_name = "rest-client"
      gem_require_name = Pantograph::PantographRequire.format_gem_require_name(gem_name)
      expect(gem_require_name).to eq("rest-client")
    end

    describe "checks if a gem is installed" do
      it "true on known installed gem" do
        gem_name = "pantograph"
        gem_installed = Pantograph::PantographRequire.gem_installed?(gem_name)
        expect(gem_installed).to be(true)
      end

      it "false on known missing gem" do
        gem_name = "foobar"
        gem_installed = Pantograph::PantographRequire.gem_installed?(gem_name)
        expect(gem_installed).to be(false)
      end

      it "true on known preinstalled gem" do
        gem_name = "yaml"
        gem_installed = Pantograph::PantographRequire.gem_installed?(gem_name)
        expect(gem_installed).to be(true)
      end
    end
  end
end
