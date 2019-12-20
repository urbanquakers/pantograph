describe Pantograph do
  describe Pantograph::LaneManager do
    describe "#init" do
      it "raises an error on invalid platform" do
        expect do
          Pantograph::LaneManager.cruise_lane(123, nil)
        end.to raise_error("platform must be a string")
      end
      it "raises an error on invalid lane" do
        expect do
          Pantograph::LaneManager.cruise_lane(nil, 123)
        end.to raise_error("lane must be a string")
      end

      describe "dotenv" do
        it "Finds the dotenv in the parent" do
          ensure_dot_env_value_from_pantograph_or_parent('withPantfiles/parentonly', nil, { DOTENV: 'parent' })
          ensure_dot_env_value_from_parent_only('withoutPantfiles/parentonly', nil, { DOTENV: 'parent' })
        end

        it "Finds the dotenv in the pantograph dir" do
          ensure_dot_env_value_from_pantograph_or_parent('withPantfiles/pantographonly', nil, { DOTENV: 'pantograph' })
          ensure_dot_env_value_from_parent_only('withoutPantfiles/pantographonly', nil, { DOTENV: 'pantograph' })
        end

        it "Finds the dotenv in the pantograph dir when in both parent and pantograph" do
          ensure_dot_env_value_from_pantograph_or_parent('withPantfiles/parentandpantograph', nil, { DOTENV: 'pantograph' })
          ensure_dot_env_value_from_parent_only('withoutPantfiles/parentandpantograph', nil, { DOTENV: 'pantograph' })
        end

        it "Doesn't find dotenv when not running in a parent of pantograph folder" do
          ensure_dot_env_value_from_parent_only('elsewhere', nil, { DOTENV: nil })
        end

        it "Supports multiple envs, and loads them in the specified order" do
          ensure_dot_env_value_from_pantograph_or_parent('multiple', "one,two", { DOTENV1: 'two', DOTENV2: 'two' })
        end

        # this method ensures that the .env file contains the expected value
        # when reading it from either pantograph or its parent
        # the pantograph folders should contain a Pantfile
        def ensure_dot_env_value_from_pantograph_or_parent(parent_dir, envs, expected_values)
          project_dir = File.absolute_path('./pantograph/spec/fixtures/dotenvs/' + parent_dir)
          pantograph_dir = File.absolute_path(project_dir + '/pantograph')
          ensure_dot_env_value_from_folders([project_dir, pantograph_dir], envs, expected_values)
        end

        # this method ensures that the .env file contains the expected value
        # when reading it from pantograph's parent only.
        # the pantograph folders shouldn't contain a Pantfile
        def ensure_dot_env_value_from_parent_only(parent_dir, envs, expected_values)
          project_dir = File.absolute_path('./pantograph/spec/fixtures/dotenvs/' + parent_dir)
          ensure_dot_env_value_from_folders([project_dir], envs, expected_values)
        end

        def ensure_dot_env_value_from_folders(folders, envs, expected_values)
          folders.each do |dir|
            expected_values.each do |k, v|
              ENV.delete(k.to_s)
            end
            Dir.chdir(dir) do
              ff = Pantograph::Helper::DotenvHelper.load_dot_env(envs)
              expected_values.each do |k, v|
                expect(ENV[k.to_s]).to eq(v)
              end
            end
          end
        end
      end

      describe "successful init" do
        before do
          allow(PantographCore::PantographFolder).to receive(:path).and_return(File.absolute_path('./pantograph/spec/fixtures/pantfiles/'))
        end

        it "Successfully handles exceptions" do
          expect do
            ff = Pantograph::LaneManager.cruise_lane('mac', 'crashy')
          end.to raise_error('my exception')
        end

        it "Uses the default platform if given" do
          ff = Pantograph::LaneManager.cruise_lane(nil, 'empty') # look, without `mac`
          lanes = ff.runner.lanes
          expect(lanes[nil][:test].description).to eq([])
          expect(lanes[:mac][:crashy].description).to eq(["This action does nothing", "but crash"])
          expect(lanes[:mac][:empty].description).to eq([])
        end

        it "Supports running a lane without a platform even when there is a default_platform" do
          path = "/tmp/pantograph/tests.txt"
          File.delete(path) if File.exist?(path)
          expect(File.exist?(path)).to eq(false)

          ff = Pantograph::LaneManager.cruise_lane(nil, 'test')

          expect(File.exist?(path)).to eq(true)
          expect(ff.runner.current_lane).to eq(:test)
          expect(ff.runner.current_platform).to eq(nil)
        end

        it "Supports running a lane with custom Pantfile path" do
          path = "./pantograph/spec/fixtures/pantfiles/PantfileCruiseLane"

          ff = Pantograph::LaneManager.cruise_lane(nil, 'test', nil, nil, path)
          lanes = ff.runner.lanes
          expect(lanes[nil][:test].description).to eq(["test description for cruise lanes"])
          expect(lanes[:mac][:apple].description).to eq([])
          expect(lanes[:linux][:robot].description).to eq([])
        end

        it "Does output a summary table when PANTOGRAPH_SKIP_ACTION_SUMMARY ENV variable is not set" do
          ENV["PANTOGRAPH_SKIP_ACTION_SUMMARY"] = nil
          expect(Terminal::Table).to(receive(:new).with(title: "pantograph summary".green, headings: anything, rows: anything))
          ff = Pantograph::LaneManager.cruise_lane(nil, 'test')
        end

        it "Does not output summary table when PANTOGRAPH_SKIP_ACTION_SUMMARY ENV variable is set" do
          ENV["PANTOGRAPH_SKIP_ACTION_SUMMARY"] = "true"
          expect(Terminal::Table).to_not(receive(:new).with(title: "pantograph summary".green, headings: anything, rows: anything))
          ff = Pantograph::LaneManager.cruise_lane(nil, 'test')
          ENV["PANTOGRAPH_SKIP_ACTION_SUMMARY"] = nil
        end
      end
    end
  end
end
