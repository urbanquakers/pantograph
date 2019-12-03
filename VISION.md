# _pantograph_’s Philosophy

_pantograph_ automates the beta and release deployment process for your iOS or Android apps, including build, code signing, automatic screenshot capture, and distribution of your app binaries.

_pantograph_ will continue to evolve in ways that make it indispensable for, and focused on these needs.

_pantograph_ aims to be elegant in success, and empathetic in failure.

_pantograph_ provides intelligent defaults for options, prompts for missing information, and a context that automatically shares relevant information between actions. All of this allows a simple, elegant Pantfile to do a lot of powerful work.

Since errors are inevitable, _pantograph_ should show empathy and provide a suggested solution, or attempt to solve the problem automatically. Errors that can be anticipated should not crash _pantograph_, and should present users with a friendly message that is easy to spot in their terminal or logs.

## Actions and Plugins

_pantograph_ saw a lot of early growth through a wide number of actions that meet a variety of needs. Actions can trigger built-in _pantograph_ tools, talk to external tools and services, and more. However, with more than 170 built-in actions, further growth here will make _pantograph_ harder to understand and get started with. Another consideration is that actions which ship with _pantograph_ represent a maintenance cost for the _pantograph_ core team.

With these challenges in mind, [_pantograph_ plugin system](https://fabric.io/blog/introducing-pantograph-plugins/) allows anyone to develop, share, and use new actions built and maintained by the awesome _pantograph_ community. If you have an idea for a new _pantograph_ action, [create it as a plugin](https://docs.pantograph.tools/plugins/create-plugin/) and it’ll be automatically listed in the [_pantograph_ plugin registry](https://docs.pantograph.tools/plugins/available-plugins). The most impactful and commonly used plugins could be adopted into _pantograph_ in the future.

## _pantograph_ Tool Responsibilities

Each _pantograph_ tool has a specific purpose and should be kept focused on the functionality required for that task.

* [boarding](https://github.com/pantograph/boarding): The easiest way to invite your TestFlight beta testers

## _pantograph_’s Relationship with [Google](https://google.com)

Google supports app development teams with the best tools for building, understanding, and growing their mobile app businesses through [Firebase](https://firebase.google.com) and [Fabric](https://get.fabric.io/).

Google has recognized _pantograph_ as the best tool for tackling tough beta and release deployment challenges. The team’s mission is to make _pantograph_ the de facto tool to automate beta deployments and app store releases for iOS and Android apps.

Google intends to keep _pantograph_ open source and available as a standalone tool for users who are not using Firebase or Fabric. Google is also committed to increasing use of _pantograph_ by promoting it through other products and websites, and developing integrations with Firebase and Fabric tools to help them work better together.
