describe Pantograph do
  describe Pantograph::PantFile do
    describe "prompt" do
      it "uses the CI value if necessary" do
        # make prompt think we're running in CI mode
        expect(Pantograph::Helper).to receive(:ci?).with(no_args).and_return(true)

        result = Pantograph::PantFile.new.parse("lane :test do
          prompt(text: 'text', ci_input: 'ci')
        end").runner.execute(:test)
        expect(result).to eq('ci')
      end

      it "reads full lines from $stdin until encountering multi_line_end_keyword" do
        # make prompt think we're running in interactive, non-CI mode
        expect(Pantograph::Helper).to receive(:ci?).with(no_args).and_return(false)

        expect($stdin).to receive(:gets).with(no_args).and_return("First line\n", "Second lineEND\n")
        result = Pantograph::PantFile.new.parse("lane :test do
          prompt(text: 'text', multi_line_end_keyword: 'END', ci_input: 'if this value is returned, prompt incorrectly assumes CI mode')
        end").runner.execute(:test)
        expect(result).to eq("First line\nSecond line")
      end
    end
  end
end
