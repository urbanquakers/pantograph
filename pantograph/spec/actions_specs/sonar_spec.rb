describe Pantograph do
  describe Pantograph::PantFile do
    describe "Sonar Integration" do
      let(:test_path) { "/tmp/pantograph/tests/pantograph" }
      let(:sonar_project_path) { "sonar-project.properties" }

      before do
        # Set up example sonar-project.properties file
        FileUtils.mkdir_p(test_path)
        File.write(File.join(test_path, sonar_project_path), '')
      end

      after(:each) do
        File.delete(File.join(test_path, sonar_project_path)) if File.exist?(File.join(test_path, sonar_project_path))
      end

      it "Should not print sonar command" do
        allow(PantographCore::PantographFolder).to receive(:path).and_return(nil)
        expected_command = "cd #{File.expand_path('.').shellescape} && sonar-scanner -Dsonar.login=\"asdf\""
        expect(Pantograph::Actions::SonarAction).to receive(:verify_sonar_scanner_binary).and_return(true)
        expect(Pantograph::Actions).to receive(:sh_control_output).with(expected_command, print_command: false, print_command_output: true).and_call_original
        Pantograph::PantFile.new.parse("lane :sonar_test do
          sonar(sonar_login: 'asdf')
        end").runner.execute(:sonar_test)
      end

      it "works with all parameters" do
        expect(Pantograph::Actions::SonarAction).to receive(:verify_sonar_scanner_binary).and_return(true)
        allow(PantographCore::PantographFolder).to receive(:path).and_return(nil)

        result = Pantograph::PantFile.new.parse("lane :test do
          sonar({
            project_configuration_path: '#{test_path}/#{sonar_project_path}',
            project_key: 'project-key',
            project_name: 'project-name',
            project_version: '1.0.0',
            sources_path: '/Sources',
            project_language: 'ruby',
            source_encoding: 'utf-8',
            sonar_login: 'sonar-login',
            sonar_url: 'http://www.sonarqube.com',
            branch_name: 'branch-name',
            pull_request_branch: 'pull-request-branch-name',
            pull_request_base: 'pull-request-base',
            pull_request_key: 'pull-request-key'
          })
        end").runner.execute(:test)

        expected = "cd #{File.expand_path('.').shellescape} && sonar-scanner
                    -Dproject.settings=\"#{test_path}/#{sonar_project_path}\"
                    -Dsonar.projectKey=\"project-key\"
                    -Dsonar.projectName=\"project-name\"
                    -Dsonar.projectVersion=\"1.0.0\"
                    -Dsonar.sources=\"/Sources\"
                    -Dsonar.language=\"ruby\"
                    -Dsonar.sourceEncoding=\"utf-8\"
                    -Dsonar.login=\"sonar-login\"
                    -Dsonar.host.url=\"http://www.sonarqube.com\"
                    -Dsonar.branch.name=\"branch-name\"
                    -Dsonar.pullrequest.branch=\"pull-request-branch-name\"
                    -Dsonar.pullrequest.base=\"pull-request-base\"
                    -Dsonar.pullrequest.key=\"pull-request-key\"".gsub(/\s+/, ' ')
        expect(result).to eq(expected)
      end
    end
  end
end