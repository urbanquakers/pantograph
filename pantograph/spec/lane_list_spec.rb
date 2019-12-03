require 'pantograph/lane_list'

describe Pantograph do
  describe Pantograph::LaneList do
    it "#generate" do
      result = Pantograph::LaneList.generate('./pantograph/spec/fixtures/pantfiles/PantfileGrouped')

      expect(result).to include("pantograph ios beta")
      expect(result).to include("Build and upload a new build to Apple")
      expect(result).to include("general")
    end

    it "#generate_json" do
      result = Pantograph::LaneList.generate_json('./pantograph/spec/fixtures/pantfiles/PantfileGrouped')
      expect(result).to eq({
        nil => {
          test: { description: "Run all the tests" },
          anotherroot: { description: "" }
 },
        :mac => {
          beta: { description: "Build and upload a new build to Apple TestFlight\nThis action will also do a build version bump and push it to git.\nThis will **not** send an email to all testers, it will only be uploaded to the new TestFlight." }
 },
        :ios => {
          beta: { description: "Submit a new version to the App Store" },
          release: { description: "" }
 },
        :android => {
          beta: { description: "Upload something to Google" },
          witherror: { description: "" },
          unsupported_action: { description: "" }
 }
 })
    end

    it "generates empty JSON if there is no Pantfile" do
      result = Pantograph::LaneList.generate_json(nil)
      expect(result).to eq({})
    end
  end
end
