<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/is_verbose.rb
-->

# is_verbose


Returns Boolean whether `--verbose` flag was set







is_verbose ||
---|---
Supported platforms | mac, linux, windows
Author | @johnknapprs



## 1 Example

```ruby
if is_verbose?
   UI.important("Verbosity is turned on!")
 else
   UI.message("Verbosity is turned off!")
 end

```





<hr />



## Lane Variables

Actions can communicate with each other using a shared hash `lane_context`, that can be accessed in other actions, plugins or your lanes: `lane_context[SharedValues:XYZ]`. The `is_verbose` action generates the following Lane Variables:

SharedValue | Description 
------------|-------------
  `SharedValues::IS_VERBOSE` | Boolean whether verbosity flag was set

To get more information check the [Lanes documentation](https://johnknapprs.github.io/pantograph/advanced/lanes/#lane-context).
<hr />


## Documentation

To show the documentation in your terminal, run
```shell
pantograph action is_verbose
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run is_verbose
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run is_verbose parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/is_verbose.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
