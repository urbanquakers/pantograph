# pantograph Plugins

The instructions below require _pantograph_ 1.93.0 or higher

_pantograph_ is an open platform and we enable every developer to extend it to fit their needs. That's why we built a plugin system that allows you and your company to provide _pantograph_ plugins to other _pantograph_ users. You have the full power and responsibility of maintaining your plugin and keeping it up to date. This is useful if you maintain your own library or web service, and want to make sure the _pantograph_ plugin is always up to date.

## Local actions

<script type="text/javascript">
(function () {
    var anchorMap = {
        "local-actions": "/create-action/"
    }
    var hash = window.location.hash.substring(1);
    if (hash) {
        if (anchorMap[hash]) {
            link = anchorMap[hash] + '#' + hash;
            window.location.replace(link);
        }
    }
})();
</script>

This content was moved and now lives [here](/create-action/#local-actions).

## Find a plugin

Head over to [Available Plugins](https://johnknapprs.github.io/pantograph/plugins/available-plugins/) for a list of plugins you can use.

List all available plugins using

```no-highlight
pantograph search_plugins
```

To search for something specific
```no-highlight
pantograph search_plugins [query]
```

## Add a plugin to your project

```no-highlight
pantograph add_plugin [name]
```

_pantograph_ will assist you on setting up your project to start using plugins.

This will:

- Add the plugin to `pantograph/Pluginfile`
- Make sure your `pantograph/Pluginfile` is properly referenced from your `./Gemfile`
- Run `pantograph install_plugins` to make sure all required dependencies are installed on your local machine (this step might ask for your admin password to install Ruby gems)
- You'll have 3 new files, that should all be checked into version control: `Gemfile`, `Gemfile.lock` and `pantograph/Pluginfile`

### Plugin Source

Your `pantograph/Pluginfile` contains the list of all _pantograph_ plugins your project uses. The `Pluginfile` is a [Gemfile](http://bundler.io/gemfile.html) that gets imported from your main `Gemfile`.
You specify all dependencies, including the required version numbers:

```ruby
# Fetched from RubyGems.org
gem "pantograph-plugin-xcversion"

# Fetched from GitHub
gem "pantograph-plugin-xcversion", git: "https://github.com/pantograph/pantograph-plugin-xcversion"

# Fetched from a local directory
gem "pantograph-plugin-xcversion", path: "../pantograph-plugin-xcversion"

# Specify a version requirements
gem "pantograph-plugin-xcversion", "1.1.0"
gem "pantograph-plugin-xcversion", ">= 1.0"
```

[More information about a Gemfile](http://bundler.io/gemfile.html)

### Run with plugins

Run _pantograph_ using `bundle exec pantograph [lane]` to make sure your plugins are properly loaded.

This is required when you use plugins from a local path or a git remote. If you have multiple versions of the same plugin loaded, you may not be using the one you specified in your `Pluginfile` or `Gemfile`.

## Install plugins on another machine

To make sure all plugins are installed on the local machine, run

```no-highlight
pantograph install_plugins
```

## Update all plugins

To make sure all plugins are updated to the latest version, run

```no-highlight
pantograph update_plugins
```

## Remove a plugin

Open your `pantograph/Pluginfile` and remove the line that looks like this

```ruby
gem "pantograph-plugin-[plugin_name]"
```
