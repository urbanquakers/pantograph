describe Pantograph do
  describe Pantograph::PantFile do
    describe "ERB template" do
      let(:template) { File.expand_path("./pantograph/spec/fixtures/templates/dummy_html_template.erb") }
      let(:destination) { "/tmp/pantograph/template.html" }

      it "generate template without placeholders" do
        result = Pantograph::PantFile.new.parse("lane :test do
          erb(
            template: '#{template}'
          )
        end").runner.execute(:test)

        expect(result).to eq("<h1></h1>\n")
      end

      it "generate template with placeholders" do
        result = Pantograph::PantFile.new.parse("lane :test do
          erb(
            template: '#{template}',
            placeholders: {
              template_name: 'ERB template name'
            }
          )
        end").runner.execute(:test)

        expect(result).to eq("<h1>ERB template name</h1>\n")
      end

      context "save to file" do
        before do
          FileUtils.mkdir_p(File.dirname(destination))
        end

        it "generate template and save to file" do
          result = Pantograph::PantFile.new.parse("lane :test do
            erb(
              template: '#{template}',
              destination: '#{destination}',
              placeholders: {
                template_name: 'ERB template name with save'
              }
            )
          end").runner.execute(:test)

          expect(result).to eq("<h1>ERB template name with save</h1>\n")
          expect(
            File.read(destination)
          ).to eq("<h1>ERB template name with save</h1>\n")
        end

        after do
          File.delete(destination)
        end
      end
    end
  end
end
