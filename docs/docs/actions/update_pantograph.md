<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/update_pantograph.rb
-->

# update_pantograph


Makes sure pantograph-tools are up-to-date when running pantograph




> This action will update pantograph to the most recent version - major version updates will not be performed automatically, as they might include breaking changes. If an update was performed, pantograph will be restarted before the run continues.<br><br>If you are using rbenv or rvm, everything should be good to go. However, if you are using the system's default ruby, some additional setup is needed for this action to work correctly. In short, pantograph needs to be able to access your gem library without running in `sudo` mode.<br><br>The simplest possible fix for this is putting the following lines into your `~/.bashrc` or `~/.zshrc` file:

```bash
export GEM_HOME=~/.gems
export PATH=$PATH:~/.gems/bin
```
>
After the above changes, restart your terminal, then run `mkdir $GEM_HOME` to create the new gem directory. After this, you're good to go!<br><br>Recommended usage of the `update_pantograph` action is at the top inside of the `before_all` block, before running any other action.


update_pantograph ||
---|---
Supported platforms | ios, android, mac
Author | @milch, @KrauseFx



## 1 Example

```ruby
before_all do
  update_pantograph
  # ...
end
```





## Parameters

Key | Description | Default
----|-------------|--------
  `nightly` | Opt-in to install and use nightly pantograph builds | `false`
  `no_update` | Don't update during this run. This is used internally | `false`
  `tools` | **DEPRECATED!** Comma separated list of pantograph tools to update (e.g. `pantograph,sigh`) | 

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action update_pantograph
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run update_pantograph
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run update_pantograph parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/johnknapprs/pantograph/blob/master/pantograph/lib/pantograph/actions/update_pantograph.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
