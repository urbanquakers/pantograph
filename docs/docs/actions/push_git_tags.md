<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/push_git_tags.rb
-->

# push_git_tags


Push local tags to the remote - this will only push tags




> If you only want to push the tags and nothing else, you can use the `push_git_tags` action


push_git_tags ||
---|---
Supported platforms | mac, linux, windows
Author | @vittoriom



## 1 Example

```ruby
push_git_tags
```





## Parameters

Key | Description | Default
----|-------------|--------
  `force` | Force push to remote | `false`
  `remote` | The remote to push tags to | `origin`
  `tag` | The tag to push to remote | 

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action push_git_tags
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run push_git_tags
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run push_git_tags parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/push_git_tags.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
