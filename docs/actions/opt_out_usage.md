<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/opt_out_usage.rb
-->

# opt_out_usage


This will stop uploading the information which actions were run




> By default, _pantograph_ will track what actions are being used. No personal/sensitive information is recorded.<br>Learn more at [https://johnknapprs.github.io/pantograph/#metrics](https://johnknapprs.github.io/pantograph/#metrics).<br>Add `opt_out_usage` at the top of your Pantfile to disable metrics collection.


opt_out_usage ||
---|---
Supported platforms | ios, android, mac
Author | @KrauseFx



## 1 Example

```ruby
opt_out_usage # add this to the top of your Pantfile
```





<hr />



## Documentation

To show the documentation in your terminal, run
```no-highlight
pantograph action opt_out_usage
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```no-highlight
pantograph run opt_out_usage
```

To pass parameters, make use of the `:` symbol, for example

```no-highlight
pantograph run opt_out_usage parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/opt_out_usage.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
