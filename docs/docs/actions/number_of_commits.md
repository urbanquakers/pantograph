<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/number_of_commits.rb
-->

# number_of_commits


Return the number of commits in current git branch







number_of_commits ||
---|---
Supported platforms | mac, linux, windows
Author | @onevcat, @samuelbeek, @johnknapprs
Returns | The total number of all commits in current git branch



## 2 Examples

```ruby

ENV["VERSION_NAME"] = number_of_commits

```

```ruby

build_number = number_of_commits(all: true)
puts build_number

```





## Parameters

Key | Description | Default
----|-------------|--------
  `all` | Returns number of all commits instead of current branch | 

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Lane Variables

Actions can communicate with each other using a shared hash `lane_context`, that can be accessed in other actions, plugins or your lanes: `lane_context[SharedValues:XYZ]`. The `number_of_commits` action generates the following Lane Variables:

SharedValue | Description 
------------|-------------
  `SharedValues::NUMBER_OF_COMMITS` | Total number of git commits

To get more information check the [Lanes documentation](https://johnknapprs.github.io/pantograph/advanced/lanes/#lane-context).
<hr />


## Documentation

To show the documentation in your terminal, run
```shell
pantograph action number_of_commits
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run number_of_commits
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run number_of_commits parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/number_of_commits.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
