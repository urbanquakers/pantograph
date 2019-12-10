require 'pathname'
require 'shellwords'

module Pantograph
  module Actions
    module SharedValues
      GRADLE_ARTIFACT_OUTPUT_PATH    = :GRADLE_ARTIFACT_OUTPUT_PATH
      GRADLE_FLAVOR                  = :GRADLE_FLAVOR
      GRADLE_BUILD_TYPE              = :GRADLE_BUILD_TYPE
    end

    class GradleAction < Action
      def self.run(params)
        task        = params[:task]
        flavor      = params[:flavor]
        build_type  = params[:build_type]
        gradle_task = [task, flavor, build_type].join

        project_dir       = params[:project_dir]
        gradle_path_param = params[:gradle_path]

        # Get the path to gradle, if it's an absolute path we take it as is, if it's relative we assume it's relative to the project_dir
        gradle_path = if Pathname.new(gradle_path_param).absolute?
                        File.expand_path(gradle_path_param)
                      else
                        File.expand_path(File.join(project_dir, gradle_path_param))
                      end

        # Ensure we ended up with a valid path to gradle
        UI.user_error!("Couldn't find gradlew at path '#{File.expand_path(gradle_path)}'") unless File.exist?(gradle_path)

        # Construct our flags
        flags = []
        flags << "-p #{project_dir.shellescape}"

        unless params[:properties].nil?
          flags << params[:properties].map { |k, v| "-P#{k.to_s.shellescape}=#{v.to_s.shellescape}" }.join(' ')
        end

        unless params[:system_properties].nil?
          flags << params[:system_properties].map { |k, v| "-D#{k.to_s.shellescape}=#{v.to_s.shellescape}" }.join(' ')
        end

        flags << params[:flags] unless params[:flags].nil?

        # Run the actual gradle task
        gradle = Helper::GradleHelper.new(gradle_path: gradle_path)

        # If these were set as properties, then we expose them back out as they might be useful to others
        Actions.lane_context[SharedValues::GRADLE_BUILD_TYPE] = build_type if build_type
        Actions.lane_context[SharedValues::GRADLE_FLAVOR] = flavor if flavor

        # We run the actual gradle task
        result = gradle.trigger(
          task: gradle_task,
          flags: flags.join(' '),
          print_command: params[:print_command],
          print_command_output: params[:print_command_output]
        )

        # If we didn't build, then we return now, as it makes no sense to search for artifacts's in a non-`assemble` or non-`build` scenario
        return result unless task =~ /\b(assemble)/ || task =~ /\b(build)/

        artifact_search_path = File.join(project_dir, '**', 'build', '**', "*.#{params[:artifact_extension].gsub('.', '')}")

        # Our artifact is now built, but there might actually be multiple ones that were built if a flavor was not specified in a multi-flavor project (e.g. `assembleRelease`)
        new_artifacts = Dir[artifact_search_path].map { |path| File.expand_path(path) }

        # We also take the most recent artifact to return as SharedValues::GRADLE_ARTIFACT_OUTPUT_PATH
        # This is the one that will be relevant for most projects that just build a single build variant (flavor + build type combo).
        # In multi build variants this value is undefined
        last_artifact_path = new_artifacts.sort_by(&File.method(:mtime)).last
        Actions.lane_context[SharedValues::GRADLE_ARTIFACT_OUTPUT_PATH] = File.expand_path(last_artifact_path) if last_artifact_path

        # Give a helpful message in case there were no new artifacts.
        # Remember we're only running this code when assembling, in which case we certainly expect there to be an artifact
        UI.message('Couldn\'t find any new artifact files...') if new_artifacts.empty?

        return result
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        'All gradle related actions, including building and testing your application'
      end

      def self.details
        'Run `./gradlew tasks` to get a list of all available gradle tasks for your project'
      end

      def self.available_options
        [
          PantographCore::ConfigItem.new(key: :task,
                                       env_name: 'GRADLE_TASK',
                                       description: 'The gradle task you want to execute, e.g. `assemble`, `bundle` or `test`. For tasks such as `assembleMyFlavorRelease` you should use gradle(task: \'assemble\', flavor: \'Myflavor\', build_type: \'Release\')',
                                       optional: false,
                                       type: String),
          PantographCore::ConfigItem.new(key: :flavor,
                                       env_name: 'GRADLE_FLAVOR',
                                       description: 'The flavor that you want the task for, e.g. `MyFlavor`. If you are running the `assemble` task in a multi-flavor project, and you rely on Actions.lane_context[SharedValues::GRADLE_APK_OUTPUT_PATH] then you must specify a flavor here or else this value will be undefined',
                                       optional: true,
                                       type: String),
          PantographCore::ConfigItem.new(key: :build_type,
                                       env_name: 'GRADLE_BUILD_TYPE',
                                       description: 'The build type that you want the task for, e.g. `Release`. Useful for some tasks such as `assemble`',
                                       optional: true,
                                       type: String),
          PantographCore::ConfigItem.new(key: :flags,
                                       env_name: 'GRADLE_FLAGS',
                                       description: 'All parameter flags you want to pass to the gradle command, e.g. `--exitcode --xml file.xml`',
                                       optional: true,
                                       type: String),
          PantographCore::ConfigItem.new(key: :project_dir,
                                       env_name: 'GRADLE_PROJECT_DIR',
                                       description: 'The root directory of the gradle project',
                                       default_value: '.',
                                       type: String),
          PantographCore::ConfigItem.new(key: :gradle_path,
                                       env_name: 'GRADLE_PATH',
                                       description: 'The path to your `gradlew`. If you specify a relative path, it is assumed to be relative to the `project_dir`',
                                       optional: true,
                                       type: String,
                                       default_value: './gradlew'),
          PantographCore::ConfigItem.new(key: :properties,
                                       env_name: 'GRADLE_PROPERTIES',
                                       description: 'Gradle properties to be exposed to the gradle script',
                                       optional: true,
                                       is_string: false),
          PantographCore::ConfigItem.new(key: :artifact_extension,
                                       env_name: 'GRADLE_ARTIFACT_EXTENSION',
                                       description: 'Gradle build output filetype extension',
                                       optional: true,
                                       is_string: true,
                                       default_value: 'jar'),
          PantographCore::ConfigItem.new(key: :system_properties,
                                       env_name: 'GRADLE_SYSTEM_PROPERTIES',
                                       description: 'Gradle system properties to be exposed to the gradle script',
                                       optional: true,
                                       is_string: false),
          PantographCore::ConfigItem.new(key: :print_command,
                                       env_name: 'GRADLE_PRINT_COMMAND',
                                       description: 'Control whether the generated Gradle command is printed as output before running it (true/false)',
                                       is_string: false,
                                       default_value: true),
          PantographCore::ConfigItem.new(key: :print_command_output,
                                       env_name: 'GRADLE_PRINT_COMMAND_OUTPUT',
                                       description: 'Control whether the output produced by given Gradle command is printed while running (true/false)',
                                       is_string: false,
                                       default_value: true)
        ]
      end

      def self.output
        [
          ['GRADLE_ARTIFACT_OUTPUT_PATH', 'The path to the newly generated artifact file. Undefined in a multi-variant assemble scenario'],
          ['GRADLE_FLAVOR', 'The flavor, e.g. `MyFlavor`'],
          ['GRADLE_BUILD_TYPE', 'The build type, e.g. `Release`']
        ]
      end

      def self.return_value
        'The output of running the gradle task'
      end

      def self.authors
        ['KrauseFx', 'lmirosevic', 'johnknapprs']
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'gradle(
            task: "assemble",
            flavor: "WorldDomination",
            build_type: "Release"
          )
          ```

          To build an AAB use:
          ```ruby
          gradle(
            task: "bundle",
            flavor: "WorldDomination",
            build_type: "Release"
          )
          ```

          You can pass properties to gradle:
          ```ruby
          gradle(
            # ...

            properties: {
              "versionCode" => 100,
              "versionName" => "1.0.0",
              # ...
            }
          )
          ```

          You can use this to automatically [sign and zipalign] your app:
          ```ruby
          gradle(
            task: "assemble",
            build_type: "Release",
            print_command: false,
            properties: {
              "app.injected.signing.store.file" => "keystore.jks",
              "app.injected.signing.store.password" => "store_password",
              "app.injected.signing.key.alias" => "key_alias",
              "app.injected.signing.key.password" => "key_password",
            }
          )
          ```

          If you need to pass sensitive information through the `gradle` action, and don\'t want the generated command to be printed before it is run, you can suppress that:
          ```ruby
          gradle(
            # ...
            print_command: false
          )
          ```

          You can also suppress printing the output generated by running the generated Gradle command:
          ```ruby
          gradle(
            # ...
            print_command_output: false
          )
          ```

          To pass any other CLI flags to gradle use:
          ```ruby
          gradle(
            # ...

            flags: "--exitcode --xml file.xml"
          )
          ```

          Delete the build directory, generated artifacts
          ```ruby
          gradle(
            task: "clean"
          )'
        ]
      end

      def self.category
        :building
      end
    end
  end
end
