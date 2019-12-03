require 'spec_helper'

describe PantographCore::UI do
  it "uses a PantographCore::Shell by default" do
    expect(PantographCore::UI.ui_object).to be_kind_of(PantographCore::Shell)
  end

  it "redirects all method calls to the current UI object" do
    expect(PantographCore::UI.ui_object).to receive(:error).with("yolo")
    PantographCore::UI.error("yolo")
  end

  it "allows overwriting of the ui_object for pantograph.ci" do
    third_party_output = "third_party_output"
    PantographCore::UI.ui_object = third_party_output

    expect(third_party_output).to receive(:error).with("yolo")
    PantographCore::UI.error("yolo")

    PantographCore::UI.ui_object = nil
  end
end
