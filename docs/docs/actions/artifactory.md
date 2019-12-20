<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/artifactory.rb
-->

# artifactory


This action uploads an artifact to artifactory







artifactory ||
---|---
Supported platforms | mac, linux, windows
Author | @koglinjg, @tommeier



## 1 Example

```ruby
artifactory(
  username: "username",
  password: "password",
  endpoint: "https://artifactory.example.com/artifactory/",
  file: "example.ipa",  # File to upload
  repo: "angular_artifacts",      # Artifactory repo
  repo_path: "/project/appname/example-major.minor.jar"   # Path to place the artifact including its filename
)
```





## Parameters

Key | Description | Default
----|-------------|--------
  `file` | File to be uploaded to artifactory | 
  `repo` | Artifactory repo to put the file in | 
  `repo_path` | Path to deploy within the repo, including filename | 
  `endpoint` | Artifactory endpoint | 
  `username` | Artifactory username | 
  `password` | Artifactory password | 
  `properties` | Artifact properties hash | `{}`
  `ssl_pem_file` | Location of pem file to use for ssl verification | 
  `ssl_verify` | Verify SSL | `true`
  `proxy_username` | Proxy username | 
  `proxy_password` | Proxy password | 
  `proxy_address` | Proxy address | 
  `proxy_port` | Proxy port | 
  `read_timeout` | Read timeout | 

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Lane Variables

Actions can communicate with each other using a shared hash `lane_context`, that can be accessed in other actions, plugins or your lanes: `lane_context[SharedValues:XYZ]`. The `artifactory` action generates the following Lane Variables:

SharedValue | Description 
------------|-------------
  `SharedValues::ARTIFACTORY_DOWNLOAD_URL` | The download url for file uploaded
  `SharedValues::ARTIFACTORY_DOWNLOAD_SIZE` | The reported file size for file uploaded

To get more information check the [Lanes documentation](https://johnknapprs.github.io/pantograph/advanced/lanes/#lane-context).
<hr />


## Documentation

To show the documentation in your terminal, run
```shell
pantograph action artifactory
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run artifactory
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run artifactory parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/artifactory.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
