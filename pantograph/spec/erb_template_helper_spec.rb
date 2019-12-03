describe Pantograph do
  require 'pantograph/lib/pantograph/erb_template_helper.rb'
  describe Pantograph::ErbTemplateHelper do
    describe "load_template" do
      it "raises an error if file does not exist" do
        expect do
          Pantograph::ErbTemplateHelper.load('invalid_name')
        end.to raise_exception("Could not find template at path '#{Pantograph::ROOT}/lib/assets/invalid_name.erb'")
      end

      it "should load file if exists" do
        f = Pantograph::ErbTemplateHelper.load('report_template.xml')
        expect(f).not_to(be_empty)
      end
    end

    describe "render_template" do
      it "renders hash values in HTML template" do
        template = File.read("./pantograph/spec/fixtures/templates/dummy_html_template.erb")
        rendered_template = Pantograph::ErbTemplateHelper.render(template, {
          template_name: "name"
        }).delete!("\n")
        expect(rendered_template).to eq("<h1>name</h1>")
      end

      it "renders with defined trim_mode" do
        template = File.read("./pantograph/spec/fixtures/templates/trim_mode_template.erb")
        rendered_template = Pantograph::ErbTemplateHelper.render(template, {}, '-')
        expect(rendered_template).to eq("line\n")
      end
    end
  end
end
