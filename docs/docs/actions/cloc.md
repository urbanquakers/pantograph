<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/cloc.rb
-->

# cloc


Generates a Code Count that can be read by Jenkins (xml format)




> This action will run cloc to generate a code count report<br>See [https://github.com/AlDanial/cloc](https://github.com/AlDanial/cloc) for more information.


cloc ||
---|---
Supported platforms | mac
Author | @johnknapprs



## 1 Example

```ruby
  # Generate JSON report of project code count
cloc(
   exclude_dir: "build",
   source_directory: ".",
   output_directory: "pantograph/reports",
   output_type: "json"
)

```





## Parameters

Key | Description | Default
----|-------------|--------
  `binary_path` | Where the cloc binary lives on your system (full path including "cloc") | `/usr/local/bin/cloc`
  `exclude_dir` | Comma separated list of directories to exclude | 
  `source_directory` | Starting point for Cloc analysis | `.`
  `output_directory` | Where to put the generated report file | `pantograph/reports`
  `output_type` | Output file type: xml, yaml, cvs, json | `yaml`
  `list_each_file` | List each individual file in cloc report | `true`

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action cloc
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run cloc
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run cloc parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/cloc.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
