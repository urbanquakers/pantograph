<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/git_pull_tags.rb
-->

# git_pull_tags


Executes a simple `git fetch --tags` command







git_pull_tags ||
---|---
Supported platforms | mac, linux, windows
Author | @urbanquakers



## 1 Example

```ruby
git_pull_tags
```





<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action git_pull_tags
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run git_pull_tags
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run git_pull_tags parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/git_pull_tags.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
