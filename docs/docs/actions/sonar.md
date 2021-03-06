<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/sonar.rb
-->

# sonar


Invokes sonar-scanner to programmatically run SonarQube analysis




> See [http://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner](http://docs.sonarqube.org/display/SCAN/Analyzing+with+SonarQube+Scanner) for details.


sonar ||
---|---
Supported platforms | mac, linux, windows
Author | @c_gretzki
Returns | The exit code of the sonar-scanner binary



## 1 Example

```ruby
sonar(
  project_key: "name.gretzki.awesomeApp",
  project_version: "1.0",
  project_name: "AwesomeApp",
  sources_path: File.expand_path("../AwesomeApp")
)
```





## Parameters

Key | Description | Default
----|-------------|--------
  `project_configuration_path` | The path to your sonar project configuration file; defaults to `sonar-project.properties` | 
  `project_key` | The key sonar uses to identify the project, e.g. `name.gretzki.awesomeApp`. Must either be specified here or inside the sonar project configuration file | 
  `project_name` | The name of the project that gets displayed on the sonar report page. Must either be specified here or inside the sonar project configuration file | 
  `project_version` | The project's version that gets displayed on the sonar report page. Must either be specified here or inside the sonar project configuration file | 
  `sources_path` | Comma-separated paths to directories containing source files. Must either be specified here or inside the sonar project configuration file | 
  `project_language` | Language key, e.g. objc | 
  `source_encoding` | Used encoding of source files, e.g., UTF-8 | 
  `sonar_runner_args` | Pass additional arguments to sonar-scanner. Be sure to provide the arguments with a leading `-D` e.g. SONAR_RUNNER_ARGS=\"-Dsonar.verbose=true\" | 
  `sonar_login` | Pass the Sonar Login token (e.g: xxxxxxprivate_token_XXXXbXX7e) | 
  `sonar_url` | Pass the url of the Sonar server | 
  `branch_name` | Pass the branch name which is getting scanned | 
  `pull_request_branch` | The name of the branch that contains the changes to be merged | 
  `pull_request_base` | The long-lived branch into which the PR will be merged | 
  `pull_request_key` | Unique identifier of your PR. Must correspond to the key of the PR in GitHub or TFS | 

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action sonar
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run sonar
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run sonar parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/sonar.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
