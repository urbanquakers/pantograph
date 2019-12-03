describe PantographCore do
  it "returns the path to the user's directory" do
    expected_path = File.join(ENV["HOME"], ".pantograph")

    expect(File).to receive(:directory?).and_return(false)
    expect(FileUtils).to receive(:mkdir_p).with(expected_path)

    expect(PantographCore.pantograph_user_dir).to eq(expected_path)
  end
end
