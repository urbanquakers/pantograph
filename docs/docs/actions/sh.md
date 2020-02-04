<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/sh.rb
-->

# sh


Runs a shell command




> Allows running an arbitrary shell command.<br>Be aware of a specific behavior of `sh` action with regard to the working directory. For details, refer to [Advanced](https://urbanquakers.github.io/pantograph/advanced/#directory-behavior).


sh ||
---|---
Supported platforms | mac, linux, windows
Author | @KrauseFx
Returns | Outputs the string and executes it. When running in tests, it returns the actual command instead of executing it



## 2 Examples

```ruby
sh("ls")
```

```ruby
sh("git", "commit", "-m", "My message")
```





## Parameters

Key | Description | Default
----|-------------|--------
  `command` | Shell command to be executed | 
  `log` | Determines whether pantograph should print out the executed command itself and output of the executed command. If command line option --troubleshoot is used, then it overrides this option to true | `true`
  `error_callback` | A callback invoked with the command output if there is a non-zero exit status | 

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action sh
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run sh
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run sh parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/sh.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
