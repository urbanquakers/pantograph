<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/add_extra_platforms.rb
-->

# add_extra_platforms


Modify the default list of supported platforms







add_extra_platforms ||
---|---
Supported platforms | ios, android, mac
Author | @lacostej



## 1 Example

```ruby
add_extra_platforms(
  platforms: [:windows, :neogeo]
)
```





## Parameters

Key | Description | Default
----|-------------|--------
  `platforms` | The optional extra platforms to support | `''`

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Documentation

To show the documentation in your terminal, run
```no-highlight
pantograph action add_extra_platforms
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```no-highlight
pantograph run add_extra_platforms
```

To pass parameters, make use of the `:` symbol, for example

```no-highlight
pantograph run add_extra_platforms parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/add_extra_platforms.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
