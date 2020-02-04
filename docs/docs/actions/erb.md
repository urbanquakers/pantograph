<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/erb.rb
-->

# erb


Allows to Generate output files based on ERB templates




> Renders an ERB template with `:placeholders` given as a hash via parameter.<br>If no `:destination` is set, it returns the rendered template as string.


erb ||
---|---
Supported platforms | mac, linux, windows
Author | @hjanuschka



## 1 Example

```ruby
# Example `erb` template:

# Variable1 <%= var1 %>
# Variable2 <%= var2 %>
# <% for item in var3 %>
#        <%= item %>
# <% end %>

erb(
  template: "1.erb",
  destination: "/tmp/rendered.out",
  placeholders: {
    :var1 => 123,
    :var2 => "string",
    :var3 => ["element1", "element2"]
  }
)
```





## Parameters

Key | Description | Default
----|-------------|--------
  `template` | ERB Template File | 
  `destination` | Destination file | 
  `placeholders` | Placeholders given as a hash | `{}`

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action erb
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run erb
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run erb parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/erb.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
