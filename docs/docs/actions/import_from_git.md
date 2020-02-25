<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/import_from_git.rb
-->

# import_from_git


Import another Pantfile from a remote git repository to use its lanes




> This is useful when sharing the same lanes across multiple projects


import_from_git ||
---|---
Supported platforms | mac, linux, windows
Author | @fabiomassimo, @KrauseFx, @Liquidsoul, @johnknapprs



## 3 Examples

```ruby
 # Simple import on master branch
  import_from_git(
    url: "git@github.com:urbanquakers/pantograph.git"
  )

```

```ruby
 # Import a Pantfile with an Optimistic version match operator
  import_from_git(
    url: "git@github.com:urbanquakers/pantograph.git",
    branch: "master",
    path: "pantograph/Pantfile",
    version: "~> 1.0.0"
  )

```

```ruby
 # Import a Pantfile with multiple version conditions
  import_from_git(
    url: "git@github.com:urbanquakers/pantograph.git", # The URL of the repository to import the Pantfile from.
    branch: "development", # The branch to checkout on the repository
    version: [">= 1.1.0", "< 2.0.0"]
  )

```





## Parameters

Key | Description | Default
----|-------------|--------
  `url` | The URL of the repository to import the Pantfile from | 
  `branch` | The branch or tag to check-out on the repository | `master`
  `path` | The path of the Pantfile in the repository | `pantograph/Pantfile`
  `dependencies` | Array of additional Pantfiles in the repository | `[]`
  `version` | The version to checkout on the repository. Optimistic match operator or multiple conditions can be used to select the version within constraints | 

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action import_from_git
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run import_from_git
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run import_from_git parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/import_from_git.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
