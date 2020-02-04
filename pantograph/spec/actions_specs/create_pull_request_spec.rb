describe Pantograph do
  describe Pantograph::PantFile do
    describe "create_pull_request" do
      let(:response_body) { File.read("./pantograph/spec/fixtures/requests/github_create_pull_request_response.json") }

      context 'successful' do
        before do
          stub_request(:post, "https://api.github.com/repos/urbanquakers/pantograph/pulls").
            with(
              body: '{"title":"test PR","head":"git rev-parse --abbrev-ref HEAD","base":"master"}',
              headers: {
                'Authorization' => 'Basic MTIzNDU2Nzg5',
                'Host' => 'api.github.com:443',
                'User-Agent' => 'pantograph-github_api'
              }
            ).to_return(status: 201, body: response_body, headers: {})

          number = JSON.parse(response_body)["number"]
          stub_request(:patch, "https://api.github.com/repos/urbanquakers/pantograph/issues/#{number}").
            with(
              body: '{"labels":["pantograph","is","awesome"]}',
              headers: {
                'Authorization' => 'Basic MTIzNDU2Nzg5',
                'Host' => 'api.github.com:443',
                'User-Agent' => 'pantograph-github_api'
              }
            ).to_return(status: 200, body: "", headers: {})

          stub_request(:post, "https://api.github.com/repos/urbanquakers/pantograph/issues/#{number}/assignees").
            with(
              body: '{"assignees":["octocat","hubot","other_user"]}',
              headers: {
                'Authorization' => 'Basic MTIzNDU2Nzg5',
                'Host' => 'api.github.com:443',
                'User-Agent' => 'pantograph-github_api'
              }
            ).to_return(status: 201, body: "", headers: {})
        end

        it 'correctly submits to github' do
          result = Pantograph::PantFile.new.parse("
            lane :test do
              create_pull_request(
                api_token: '123456789',
                title: 'test PR',
                repo: 'urbanquakers/pantograph',
              )
            end
          ").runner.execute(:test)

          expect(result).to eq('https://github.com/urbanquakers/pantograph/pull/1347')
        end

        it 'correctly submits to github with labels' do
          result = Pantograph::PantFile.new.parse("
            lane :test do
              create_pull_request(
                api_token: '123456789',
                title: 'test PR',
                repo: 'urbanquakers/pantograph',
                labels: ['pantograph', 'is', 'awesome']
              )
            end
          ").runner.execute(:test)

          expect(result).to eq('https://github.com/urbanquakers/pantograph/pull/1347')
        end

        it 'correctly submits to github with assignees' do
          result = Pantograph::PantFile.new.parse("
            lane :test do
              create_pull_request(
                api_token: '123456789',
                title: 'test PR',
                repo: 'urbanquakers/pantograph',
                assignees: ['octocat','hubot','other_user']
              )
            end
          ").runner.execute(:test)

          expect(result).to eq('https://github.com/urbanquakers/pantograph/pull/1347')
        end
      end
    end
  end
end
