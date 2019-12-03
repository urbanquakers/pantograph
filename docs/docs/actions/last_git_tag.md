<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/last_git_tag.rb
-->

# last_git_tag


Get the most recent git tag




> If you are using this action on a **shallow clone**, *the default with some CI systems like Bamboo*, you need to ensure that you have also pulled all the git tags appropriately. Assuming your git repo has the correct remote set you can issue `sh('git fetch --tags')`.


last_git_tag ||
---|---
Supported platforms | ios, android, mac
Author | @KrauseFx



## 1 Example

```ruby
last_git_tag
```





<hr />



## Documentation

To show the documentation in your terminal, run
```no-highlight
pantograph action last_git_tag
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```no-highlight
pantograph run last_git_tag
```

To pass parameters, make use of the `:` symbol, for example

```no-highlight
pantograph run last_git_tag parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/last_git_tag.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
