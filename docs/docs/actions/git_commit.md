<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/git_commit.rb
-->

# git_commit


Directly commit the given file with the given message







git_commit ||
---|---
Supported platforms | mac, linux, windows
Author | @KrauseFx



## 4 Examples

```ruby
git_commit(path: "./version.txt", message: "Version Bump")
```

```ruby
git_commit(path: ["./version.txt", "./changelog.txt"], message: "Version Bump")
```

```ruby
git_commit(path: ["./*.txt", "./*.md"], message: "Update documentation")
```

```ruby
git_commit(path: ["./*.txt", "./*.md"], message: "Update documentation", skip_git_hooks: true)
```





## Parameters

Key | Description | Default
----|-------------|--------
  `path` | The file you want to commit | 
  `message` | The commit message that should be used | 
  `skip_git_hooks` | Set to true to pass --no-verify to git | 
  `allow_nothing_to_commit` | Set to true to allow commit without any git changes | 

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action git_commit
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run git_commit
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run git_commit parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/git_commit.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
