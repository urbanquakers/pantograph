<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/ensure_env_vars.rb
-->

# ensure_env_vars


Raises an exception if the specified env vars are not set







ensure_env_vars ||
---|---
Supported platforms | mac, linux, windows
Author | @johnknapprs



## 1 Example

```ruby
ensure_env_vars(
  vars: ['GITHUB_USER_NAME', 'GITHUB_API_TOKEN']
)
```





## Parameters

Key | Description | Default
----|-------------|--------
  `vars` | The ENV variables keys to verify | 

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action ensure_env_vars
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run ensure_env_vars
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run ensure_env_vars parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/ensure_env_vars.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
