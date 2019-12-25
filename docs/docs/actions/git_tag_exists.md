<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/git_tag_exists.rb
-->

# git_tag_exists


Checks if the git tag with the given name exists in the current repo







git_tag_exists ||
---|---
Supported platforms | mac, linux, windows
Author | @antondomashnev
Returns | Boolean value whether the tag exists or not



## 1 Example

```ruby
if git_tag_exists(tag: "1.1.0")
  UI.message("Found it 🚀")
end
```





## Parameters

Key | Description | Default
----|-------------|--------
  `tag` | The tag name that should be checked | 
  `remote` | Whether to check remote. Defaults to `false` | `false`
  `remote_name` | The remote to check. Defaults to `origin` | `origin`

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


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

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/git_tag_exists.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>