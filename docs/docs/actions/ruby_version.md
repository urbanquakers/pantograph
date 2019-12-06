<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/ruby_version.rb
-->

# ruby_version


Verifies the minimum ruby version required




> Add this to your `Pantfile` to require a certain version of _ruby_.<br>Put it at the top of your `Pantfile to ensure that _pantograph_ is executed appropriately.


ruby_version ||
---|---
Supported platforms | ios, android, mac
Author | @sebastianvarela



## 1 Example

```ruby
ruby_version("2.4.0")
```





<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action ruby_version
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run ruby_version
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run ruby_version parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/ruby_version.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
