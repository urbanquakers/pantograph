<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/ensure_git_status_clean.rb
-->

# ensure_git_status_clean


Raises error if there are uncommitted git changes







ensure_git_status_clean ||
---|---
Supported platforms | mac, linux, windows
Author | @lmirosevic, @antondomashnev, @johnknapprs



## 1 Example

```ruby
before_all do
   # Prevent pantograph from running lanes when git is in a dirty state
   ensure_git_status_clean
 end
```





<hr />



## Lane Variables

Actions can communicate with each other using a shared hash `lane_context`, that can be accessed in other actions, plugins or your lanes: `lane_context[SharedValues:XYZ]`. The `ensure_git_status_clean` action generates the following Lane Variables:

SharedValue | Description 
------------|-------------
  `SharedValues::ENSURE_GIT_STATUS_CLEAN` | Returns `true` if status clean when executed

To get more information check the [Lanes documentation](https://johnknapprs.github.io/pantograph/advanced/lanes/#lane-context).
<hr />


## Documentation

To show the documentation in your terminal, run
```shell
pantograph action ensure_git_status_clean
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run ensure_git_status_clean
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run ensure_git_status_clean parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/ensure_git_status_clean.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
