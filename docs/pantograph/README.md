pantograph documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```shell
xcode-select --install
```

Install _pantograph_ using

```shell
# Intall ruby with Homebrew
brew install ruby

# Set ruby in your shell PATH
export PATH="/usr/local/opt/ruby/bin:$PATH"

# Install Pantograph from Rubygems
gem install pantograph
```

<!-- or alternatively using `brew cask install pantograph` -->

# Available Actions
### test
```shell
pantograph test
```

### post_slack_deploy_message
```shell
pantograph post_slack_deploy_message
```

### update_available_plugins
```shell
pantograph update_available_plugins
```


----

This README.md is auto-generated and will be re-generated every time [_pantograph_](https://pantograph.tools) is run.
More information about pantograph can be found on [pantograph.tools](https://pantograph.tools).
The documentation of pantograph can be found on [johnknapprs.github.io/pantograph](https://johnknapprs.github.io/pantograph).
