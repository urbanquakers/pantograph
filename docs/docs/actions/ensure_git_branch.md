<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/ensure_git_branch.rb
-->

# ensure_git_branch


Raises an exception if not on a specific git branch




> This action will check if your git repo is checked out to a specific branch.<br>You may only want to make releases from a specific branch, so `ensure_git_branch` will stop a lane if it was accidentally executed on an incorrect branch.


ensure_git_branch ||
---|---
Supported platforms | mac, linux, windows
Author | @dbachrach, @Liquidsoul, @johnknapprs



## 2 Examples

```ruby
ensure_git_branch # defaults to `master` branch
```

```ruby
ensure_git_branch(
  branch: 'develop'
)
```





## Parameters

Key | Description | Default
----|-------------|--------
  `branch` | The branch that should be checked for. String that can be either the full name of the branch or a regex to match | `master`

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action ensure_git_branch
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run ensure_git_branch
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run ensure_git_branch parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/ensure_git_branch.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
