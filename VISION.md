# _pantograph_’s Philosophy

_pantograph_ automates the process for your apps, including config, test,build, and deploy

_pantograph_ will continue to evolve in ways that make it indispensable for, and focused on these needs.

_pantograph_ aims to be elegant in success, and empathetic in failure.

_pantograph_ provides intelligent defaults for options, prompts for missing information, and a context that automatically shares relevant information between actions. All of this allows a simple, elegant Pantfile to do a lot of powerful work.

Since errors are inevitable, _pantograph_ should show empathy and provide a suggested solution, or attempt to solve the problem automatically. Errors that can be anticipated should not crash _pantograph_, and should present users with a friendly message that is easy to spot in their terminal or logs.

## Actions and Plugins

_pantograph_ saw a lot of early growth through a wide number of actions that meet a variety of needs. Actions can trigger built-in _pantograph_ tools, talk to external tools and services, and more. However, with more than 170 built-in actions, further growth here will make _pantograph_ harder to understand and get started with. Another consideration is that actions which ship with _pantograph_ represent a maintenance cost for the _pantograph_ core team.

With these challenges in mind, [_pantograph_ plugin system](https://fabric.io/blog/introducing-pantograph-plugins/) allows anyone to develop, share, and use new actions built and maintained by the awesome _pantograph_ community. If you have an idea for a new _pantograph_ action, [create it as a plugin](https://urbanquakers.github.io/pantograph/plugins/create-plugin/) and it’ll be automatically listed in the [_pantograph_ plugin registry](https://urbanquakers.github.io/pantograph/plugins/available-plugins). The most impactful and commonly used plugins could be adopted into _pantograph_ in the future.

## _pantograph_ Tool Responsibilities

Each _pantograph_ tool has a specific purpose and should be kept focused on the functionality required for that task.

## _pantograph_ Roadmap

| Goal                      | Completed |
| ------------------------- | --------- |
| 80% > Test Coverage       |           |
| 80% > Yard Doc Coverage   |           |
| Markdown Linting          |           |
| Fix Plugin Functionality  |           |
| Improve Contrib Process   |           |
| Fix CI/CD Process         |           |
| Resolve Tool Concept      |           |
| Twitter Publication Notif |           |
| Docs include blogs        |           |
| Impv action Example Code  |           |

- Resolve old References in Code Examples
  - crashlytics
  - increment_build_number
- Remove Swift References
