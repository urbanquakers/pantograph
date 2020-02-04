![img/pantograph_text.png](img/pantograph_text.png)

pantograph
============

[![Twitter: @PantographTools](https://img.shields.io/badge/contact-@PantographTools-blue.svg?style=flat)](https://twitter.com/PantographTools){: .badge }
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/urbanquakers/pantograph/blob/master/LICENSE){: .badge }
[![Gem](https://img.shields.io/gem/v/pantograph.svg?style=flat)](https://rubygems.org/gems/pantograph){: .badge }

_pantograph_ is another way to automate releases for your apps.
🚀 It handles all tedious tasks, like generating screenshots, dealing with code signing, and releasing your application.

You can start by creating a `Pantfile` file in your repository, here’s one that defines your release process:

```ruby
lane :release do
  test_app
  build_app
  deploy_app
end

lane :test_app do
  gradle(task: 'clean testRelease')
end

lane :build_app do
  gradle(task: 'clean assembleRelease')
end

lane :deploy_app do
  artifactory
  slack # Let your team-mates know the new version is live
end
```

You just defined 4 different lanes, one for release deployement. To release your app, all you have to do is:

```shell
pantograph release
```

## Why pantograph?

|              | pantograph
-------------- | ----------
🚀 | Save **hours** every time you push a new release
✨ | Integrates with many of your existing tools and services
📖 | 100% open source under the MIT license
🎩 | Easy setup assistant to get started in a few minutes
⚒  | Runs on **your** machine, it's your app and your data
👻 | Integrates with all major CI systems
🔧 | Extend and customise _pantograph_ to fit your needs, you're not dependent on anyone
💭 | Never remember any commands any more, just _pantograph_
🚢 | Deploy from any computer, including a CI server

## Getting Started

{!docs/includes/installing-pantograph.md!}

Navigate to your project and run

```shell
pantograph init
```

_pantograph_ will automatically detect your project, and ask for any missing information.

For more details about how to get up and running, check out the getting started guides:


- [pantograph Getting Started guide for Gradle](getting-started/TODO/setup.md)
- [pantograph Getting Started guide for Multi-lane pipeline](getting-started/TODO/setup.md)


## Questions and support

Before submitting a new GitHub issue, please make sure to search for [existing GitHub issues](https://github.com/urbanquakers/pantograph/issues).

If that doesn't help, please [submit an issue](https://github.com/urbanquakers/pantograph/issues) on GitHub and provide information
about your setup, in particular the output of the `pantograph env` command.

## System requirements

Currently, _pantograph_ is officially supported to run on Linux and macOS. 

But we are working on 🖥️ Windows support for parts of _pantograph_. Many other tools and actions can theoretically also work on other platforms.

## _pantograph_ team

<table>
<tr>
<td>
<a href='https://twitter.com/petrosichor'><img src='https://github.com/urbanquakers.png?size=200' width=140></a>
<h4 align='center'><a href='https://twitter.com/petrosichor'>John Knapp</a></h4>
</td>
</table>

Special thanks to all [contributors](https://github.com/urbanquakers/pantograph/graphs/contributors) for extending and improving _pantograph_.

## Metrics
 
_pantograph_ tracks a few key metrics to understand how developers are using the tool and to help us know what areas need improvement. No personal/sensitive information is ever collected. Metrics that are collected include: 
 
* The number of _pantograph_ runs
* A salted hash of the app identifier or package name, which helps us anonymously identify unique usage of _pantograph_
 
You can easily opt-out of metrics collection by adding `opt_out_usage` at the top of your `Pantfile` or by setting the environment variable `PANTOGRAPH_OPT_OUT_USAGE`. [Check out the metrics code on GitHub](https://github.com/urbanquakers/pantograph/tree/master/pantograph_core/lib/pantograph_core/analytics)

## License

This project is licensed under the terms of the MIT license. See the [LICENSE](https://github.com/urbanquakers/pantograph/blob/master/LICENSE) file.

----
