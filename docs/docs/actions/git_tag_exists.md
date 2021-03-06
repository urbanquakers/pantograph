<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/git_tag_exists.rb
-->

# git_tag_exists


Checks if the git tag with the given name exists







git_tag_exists ||
---|---
Supported platforms | mac, linux, windows
Author | @johnknapprs
Returns | Returns Boolean value whether the tag exists



## 1 Example

```ruby
if git_tag_exists(tag: "1.1.0")
  UI.message("Git Tag Exists!")
end
```





## Parameters

Key | Description | Default
----|-------------|--------
  `tag` | The tag name that should be checked | 

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Lane Variables

Actions can communicate with each other using a shared hash `lane_context`, that can be accessed in other actions, plugins or your lanes: `lane_context[SharedValues:XYZ]`. The `git_tag_exists` action generates the following Lane Variables:

SharedValue | Description 
------------|-------------
  `SharedValues::GIT_TAG_EXISTS` | Boolean value whether tag exists

To get more information check the [Lanes documentation](https://urbanquakers.github.io/pantograph/advanced/lanes/#lane-context).
<hr />


## Documentation

To show the documentation in your terminal, run
```shell
pantograph action git_tag_exists
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run git_tag_exists
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run git_tag_exists parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/git_tag_exists.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
