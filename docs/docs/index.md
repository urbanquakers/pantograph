![img/pantograph_text.png](img/pantograph_text.png)

pantograph
============

[![Twitter: @PantographTools](https://img.shields.io/badge/contact-@PantographTools-blue.svg?style=flat)](https://twitter.com/PantographTools){: .badge }
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/pantograph/pantograph/blob/master/LICENSE){: .badge }
[![Gem](https://img.shields.io/gem/v/pantograph.svg?style=flat)](https://rubygems.org/gems/pantograph){: .badge }

_pantograph_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. 🚀 It handles all tedious tasks, like generating screenshots, dealing with code signing, and releasing your application.

You can start by creating a `Pantfile` file in your repository, here’s one that defines your beta or App Store release process:

```ruby
lane :beta do
  increment_build_number
  build_app
  upload_to_testflight
end

lane :release do
  capture_screenshots
  build_app
  upload_to_app_store       # Upload the screenshots and the binary to iTunes
  slack                     # Let your team-mates know the new version is live
end
```

You just defined 2 different lanes, one for beta deployment, one for App Store. To release your app in the App Store, all you have to do is

```shell
pantograph release
```

## Why pantograph?

|              | pantograph
-------------- | ----------
🚀 | Save **hours** every time you push a new release to the store or beta testing service
✨ | Integrates with all your existing tools and services (more than 400 integrations)
📖 | 100% open source under the MIT license
🎩 | Easy setup assistant to get started in a few minutes
⚒ | Runs on **your** machine, it's your app and your data
👻 | Integrates with all major CI systems
🖥 | Supports iOS, Mac, and Android apps
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

<!--
- [pantograph Getting Started guide for iOS](getting-started/ios/setup.md)
- [pantograph Getting Started guide for Android](getting-started/android/setup.md)
-->

## Questions and support

Before submitting a new GitHub issue, please make sure to search for [existing GitHub issues](https://github.com/pantograph/pantograph/issues).

If that doesn't help, please [submit an issue](https://github.com/pantograph/pantograph/issues) on GitHub and provide information about your setup, in particular the output of the `pantograph env` command.

## System requirements

Currently, _pantograph_ is officially supported to run on macOS. 

But we are working on 🐧 Linux and 🖥️ Windows support for parts of _pantograph_. Some underlying software like Xcode or iTunes Transporter is only available for macOS, but many other tools and actions can theoretically also work on other platforms. Please see [this Github issue for further information](https://github.com/pantograph/pantograph/issues/11687).

## _pantograph_ team

<table>
<tr>
<td>
<a href='https://twitter.com/petrosichor'><img src='https://github.com/johnknapprs.png?size=200' width=140></a>
<h4 align='center'><a href='https://twitter.com/petrosichor'>John Knapp</a></h4>
</td>
</table>

Special thanks to all [contributors](https://github.com/johnknapprs/pantograph/graphs/contributors) for extending and improving _pantograph_.

## Metrics
 
_pantograph_ tracks a few key metrics to understand how developers are using the tool and to help us know what areas need improvement. No personal/sensitive information is ever collected. Metrics that are collected include: 
 
* The number of _pantograph_ runs
* A salted hash of the app identifier or package name, which helps us anonymously identify unique usage of _pantograph_
 
You can easily opt-out of metrics collection by adding `opt_out_usage` at the top of your `Pantfile` or by setting the environment variable `PANTOGRAPH_OPT_OUT_USAGE`. [Check out the metrics code on GitHub](https://github.com/pantograph/pantograph/tree/master/pantograph_core/lib/pantograph_core/analytics)

## License

This project is licensed under the terms of the MIT license. See the [LICENSE](https://github.com/pantograph/pantograph/blob/master/LICENSE) file.

----
### Where to go from here?
<!--
- [pantograph Getting Started guide for iOS](getting-started/ios/setup.md)
- [pantograph Getting Started guide for Android](getting-started/android/setup.md)
-->
