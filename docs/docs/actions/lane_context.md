<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/lane_context.rb
-->

# lane_context


Access lane context values




> More information about how the lane context works: [https://johnknapprs.github.io/pantograph/advanced/#lane-context](https://johnknapprs.github.io/pantograph/advanced/#lane-context)


lane_context ||
---|---
Supported platforms | mac, linux, windows
Author | @KrauseFx



## 2 Examples

```ruby
lane_context[:BUILD_NUMBER]
```

```ruby
lane_context[SharedValues::IPA_OUTPUT_PATH]
```





<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action lane_context
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run lane_context
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run lane_context parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/lane_context.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
