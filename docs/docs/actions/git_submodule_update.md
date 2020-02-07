<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/git_submodule_update.rb
-->

# git_submodule_update


Execute git submodule command







git_submodule_update ||
---|---
Supported platforms | mac, linux, windows
Author | @johnknapprs





## Parameters

Key | Description | Default
----|-------------|--------
  `recursive` | Add the `--recursive` flag | `false`
  `init` | Add the `--init` flag | `false`

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action git_submodule_update
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run git_submodule_update
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run git_submodule_update parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/git_submodule_update.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
