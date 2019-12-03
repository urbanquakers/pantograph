{!docs/includes/setup-pantograph-header.md!}

# pantograph

## Configuring pantograph

### Skip update check when launching _pantograph_

You can set the environment variable `PANTOGRAPH_SKIP_UPDATE_CHECK` to skip the update check.

### Hide changelog information at the end of running _pantograph_

You can set the environment variable `PANTOGRAPH_HIDE_CHANGELOG` to hide the detailed changelog information when new _pantograph_ versions are available.

### Output environment variables

- To hide timestamps in each row, set the `PANTOGRAPH_HIDE_TIMESTAMP` environment variable to true (overruled by `--verbose`). 
- To disable output formatting, set the `PANTOGRAPH_DISABLE_OUTPUT_FORMAT` environment variable to true.

## How pantograph works

### Priorities of parameters and options

The order in which _pantograph_ tools take their values from

1. CLI parameter (e.g. `gym --scheme Example`) or Pantfile (e.g. `gym(scheme: 'Example')`)
1. Environment variable (e.g. `GYM_SCHEME`)
1. Tool specific config file (e.g. `Gymfile` containing `scheme 'Example'`)
1. Default value (which might be taken from the `Appfile`, e.g. `app_identifier` from the `Appfile`)
1. If this value is required, you'll be asked for it (e.g. you have multiple schemes, you'll be asked for it)

### Directory behavior

_pantograph_ was designed in a way that you can run _pantograph_ from both the root directory of the project, and from the `./pantograph` sub-folder.

Take this example `Pantfile` on the path `pantograph/Pantfile`
```ruby
sh "pwd" # => "[root]/pantograph"
puts Dir.pwd # => "[root]/pantograph"

lane :something do
  sh "pwd" # => "[root]/pantograph"
  puts Dir.pwd # => "[root]/pantograph"

  my_action
end
```

The implementation of `my_action` looks like this:
```ruby
def run(params)
  puts Dir.pwd # => "[root]"
end
```

Notice how every action and every plugin's code runs in the root of the project, while all user code from the `Pantfile` runs inside the `./pantograph` directory. This is important to consider when migrating existing code from your `Pantfile` into your own action or plugin. To change the directory manually you can use standard Ruby blocks:

```ruby
Dir.chdir("..") do
  # code here runs in the parent directory
end
```

This behavior isn't great, and has been like this since the very early days of _pantograph_. As much as we'd like to change it, there is no good way to do so, without breaking thousands of production setups, so we decided to keep it as is for now.

## Passing parameters to _pantograph_ command line tools

_pantograph_ contains several command line tools, e.g. [`pantograph deliver`](/actions/deliver/) or [`pantograph snapshot`](/actions/snapshot/). To pass parameters to these tools, append the option names and values as you would for a normal shell command:

```shell
pantograph [tool] --[option]=[value]

pantograph deliver --skip_screenshots=true
pantograph snapshot --screenshots_path=xxxxx --schema=xxxx
```
