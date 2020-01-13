<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/is_ci.rb
-->

# is_ci


Is the current run being executed on a CI system, like Jenkins or Travis




> Return `true` if pantograph is currently executed on Travis, Jenkins, or a similar CI service


is_ci ||
---|---
Supported platforms | mac, linux, windows
Author | @KrauseFx



## 1 Example

```ruby
if is_ci?
  puts "I'm a computer"
else
  say "Hi Human!"
end
```





<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action is_ci
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run is_ci
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run is_ci parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/is_ci.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
