<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/zip.rb
-->

# zip


Compress a file or folder to a zip







zip ||
---|---
Supported platforms | mac, linux, windows
Author | @KrauseFx
Returns | The path to the output zip file



## 4 Examples

```ruby
zip
```

```ruby
zip(
  path: "MyApp.app",
  output_path: "Latest.app.zip"
)
```

```ruby
zip(
  path: "MyApp.app",
  output_path: "Latest.app.zip",
  verbose: false
)
```

```ruby
zip(
  path: "MyApp.app",
  output_path: "Latest.app.zip",
  verbose: false,
  symlinks: true
)
```





## Parameters

Key | Description | Default
----|-------------|--------
  `path` | Path to the directory or file to be zipped | 
  `output_path` | The name of the resulting zip file | 
  `verbose` | Enable verbose output of zipped file | `true`
  `password` | Encrypt the contents of the zip archive using a password | 
  `symlinks` | Store symbolic links as such in the zip archive | `false`

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action zip
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run zip
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run zip parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/zip.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>