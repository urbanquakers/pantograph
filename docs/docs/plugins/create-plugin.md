# Create your own pantograph plugin

```no-highlight
cd ~/new/folder/

pantograph new_plugin [plugin_name]
```

- _pantograph_ creates the directory structure that's needed to be a valid Ruby gem
- Edit the `lib/pantograph/plugin/[plugin_name]/actions/[plugin_name].rb` and implement your action
- Easily test the plugin locally by running `pantograph add_plugin` in your project's directory and specifying the local path when asked for it

## New plugin for existing gem

If you already have an existing gem you want to provide a _pantograph_ plugin for, you'll still have to create a new Ruby gem. The reason for that is the way plugins are imported.

The example project [xcake](https://github.com/jcampbell05/xcake) contains a folder named `pantograph-plugin-xcake`.

All you have to do if you have an existing gem:

- Navigate to your gem
- `pantograph new_plugin [plugin_name]`
- Inside the newly created folder, edit the `pantograph-plugin-[plugin_name].gemspec` and add your gem as a dependency. It is recommended to also specify a version number requirement

## Publishing your plugin

### RubyGems

The recommended way to publish your plugin is to publish it on [RubyGems.org](https://rubygems.org). Follow the steps below to publish your plugin.

1. Create an account at [RubyGems.org](https://rubygems.org)
2. Publish your plugin to a [GitHub](https://github.com) repo
3. Update the `pantograph-plugin-[plugin_name].gemspec` file so that the `spec.homepage` points to your github repo.
4. Publish the first release of your plugin:
```sh
bundle install
rake install
rake release
```

Now all your users can run `pantograph add_plugin [plugin_name]` to install and use your plugin.

### GitHub

If for some reason you don't want to use RubyGems, you can also make your plugin available on GitHub. Your users then need to add the following to the `Pluginfile`

```ruby
gem "pantograph-plugin-[plugin_name]", git: "https://github.com/[user]/[plugin_name]"
```

## Advanced

### Multiple actions in one plugin

Let's assume you work on a _pantograph_ plugin for project management software. You could call it `pantograph-plugin-pm` and it may contain any number of actions and helpers, just add them to your `actions` folder. Make sure to mention the available actions in your plugin's `README.md`.
