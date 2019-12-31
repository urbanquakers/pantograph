describe Pantograph do
  describe Pantograph::PantFile do
    describe "danger integration" do
      before :each do
        allow(PantographCore::PantographFolder).to receive(:path).and_return(nil)
      end

      it "default use case" do
        result = Pantograph::PantFile.new.parse("lane :test do
          danger
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --dangerfile=Dangerfile --fail-on-errors=false")
      end

      it "no bundle exec" do
        result = Pantograph::PantFile.new.parse("lane :test do
          danger(use_bundle_exec: false)
        end").runner.execute(:test)

        expect(result).to eq("danger --dangerfile=Dangerfile --fail-on-errors=false")
      end

      it "appends verbose" do
        result = Pantograph::PantFile.new.parse("lane :test do
          danger(verbose: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --dangerfile=Dangerfile --verbose --fail-on-errors=false")
      end

      it "sets github token" do
        result = Pantograph::PantFile.new.parse("lane :test do
          danger(github_api_token: '1234')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --dangerfile=Dangerfile --fail-on-errors=false")
        expect(ENV['DANGER_GITHUB_API_TOKEN']).to eq("1234")
      end

      it "appends danger_id" do
        result = Pantograph::PantFile.new.parse("lane :test do
          danger(danger_id: 'unit-tests')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --dangerfile=Dangerfile --danger_id=unit-tests --fail-on-errors=false")
      end

      it "appends dangerfile" do
        result = Pantograph::PantFile.new.parse("lane :test do
          danger(dangerfile: 'test/OtherDangerfile')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --dangerfile=test/OtherDangerfile --fail-on-errors=false")
      end

      it "appends fail-on-errors flag when set" do
        result = Pantograph::PantFile.new.parse("lane :test do
          danger(fail_on_errors: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --dangerfile=Dangerfile --fail-on-errors=true")
      end

      it "appends new-comment flag when set" do
        result = Pantograph::PantFile.new.parse("lane :test do
          danger(new_comment: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --dangerfile=Dangerfile --new-comment --fail-on-errors=false")
      end

      it "does not append new-comment flag when unset" do
        result = Pantograph::PantFile.new.parse("lane :test do
          danger(new_comment: false)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --dangerfile=Dangerfile --fail-on-errors=false")
      end

      it "appends remove-previous-comments flag when set" do
        result = Pantograph::PantFile.new.parse("lane :test do
          danger(remove_previous_comments: true)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --dangerfile=Dangerfile --remove-previous-comments --fail-on-errors=false")
      end

      it "does not append remove-previous-comments flag when unset" do
        result = Pantograph::PantFile.new.parse("lane :test do
          danger(remove_previous_comments: false)
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --dangerfile=Dangerfile --fail-on-errors=false")
      end

      it "appends base" do
        result = Pantograph::PantFile.new.parse("lane :test do
          danger(base: 'master')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --dangerfile=Dangerfile --base=master --fail-on-errors=false")
      end

      it "appends head" do
        result = Pantograph::PantFile.new.parse("lane :test do
          danger(head: 'master')
        end").runner.execute(:test)

        expect(result).to eq("bundle exec danger --dangerfile=Dangerfile --head=master --fail-on-errors=false")
      end
    end
  end
end
