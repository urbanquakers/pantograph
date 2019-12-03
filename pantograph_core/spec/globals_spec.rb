require 'spec_helper'

describe PantographCore do
  describe PantographCore::Globals do
    it "Toggle verbose mode" do
      PantographCore::Globals.verbose = true
      expect(PantographCore::Globals.verbose?).to eq(true)
      PantographCore::Globals.verbose = false
      expect(PantographCore::Globals.verbose?).to eq(nil)
    end

    it "Toggle capture_mode " do
      PantographCore::Globals.capture_output = true
      expect(PantographCore::Globals.capture_output?).to eq(true)
      PantographCore::Globals.capture_output = false
      expect(PantographCore::Globals.capture_output?).to eq(nil)
    end
  end
end
