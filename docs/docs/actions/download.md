<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/download.rb
-->

# download


Download a file from a remote server (e.g. JSON file)




> Specify the URL to download and get the content as a return value.<br>Automatically parses JSON into a Ruby data structure.


download ||
---|---
Supported platforms | mac, linux, windows
Author | @KrauseFx



## 1 Example

```ruby
data = download(url: "https://host.com/api.json")
```





## Parameters

Key | Description | Default
----|-------------|--------
  `url` | The URL that should be downloaded | 

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Lane Variables

Actions can communicate with each other using a shared hash `lane_context`, that can be accessed in other actions, plugins or your lanes: `lane_context[SharedValues:XYZ]`. The `download` action generates the following Lane Variables:

SharedValue | Description 
------------|-------------
  `SharedValues::DOWNLOAD_CONTENT` | The content of the file we just downloaded

To get more information check the [Lanes documentation](https://urbanquakers.github.io/pantograph/advanced/lanes/#lane-context).
<hr />


## Documentation

To show the documentation in your terminal, run
```shell
pantograph action download
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run download
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run download parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/download.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
