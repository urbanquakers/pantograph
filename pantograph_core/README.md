PantographCore
============

[![Twitter: @PantographTools](https://img.shields.io/badge/contact-@PantographTools-blue.svg?style=flat)](https://twitter.com/PantographTools)
[![License](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/urbanquakers/pantograph/blob/master/LICENSE)

All shared code of the pantograph tools is stored in this repository.

Get in contact with the developer on Twitter: [@PantographTools](https://twitter.com/PantographTools)

# Features

This gem contains all shared classes and code:

- Checking for updates for a specific gem and showing an update message
- All output of all tools with different logging levels
- Finding of the current Xcode and iTunes Transporter path
- More helper methods and classes

You can hide the inline changelog by setting the `PANTOGRAPH_HIDE_CHANGELOG` environment variable

## Output environment variables

- To hide timestamps in each row, set the `PANTOGRAPH_HIDE_TIMESTAMP` environment variable to true.
- To disable output formatting, set the `PANTOGRAPH_DISABLE_OUTPUT_FORMAT` environment variable to true.

## Interacting with the user

Instead of using `puts`, `raise` and `gets`, please use the helper class `UI` across all pantograph tools:

```ruby
UI.message("Neutral message (usually white)")
UI.success("Successfully finished processing (usually green)")
UI.error("Wahaha, what's going on here! (usually red)")
UI.important("Make sure to use Windows (usually yellow)")

UI.header("Inputs") # a big box

name = UI.input("What's your name? ")
if UI.confirm("Are you '#{name}'?")
  UI.success("Oh yeah")
else
  UI.error("Wups, invalid")
end

UI.password("Your password please: ") # password inputs are hidden

###### A "Dropdown" for the user
project = UI.select("Select your project: ", ["Test Project", "Test Workspace"])

UI.success("Okay #{name}, you selected '#{project}'")

###### To run a command use
PantographCore::CommandExecutor.execute(command: "ls",
                                    print_all: true,
                                        error: proc do |error_output|
                                          # handle error here
                                        end)

###### or if you just want to receive a simple value use this only if the command doesn't take long
diff = Helper.backticks("git diff")

###### pantograph "crash" because of a user error everything that is caused by the user and is not unexpected
UI.user_error!("You don't have a project in the current directory")

###### an actual crash when something unexpected happened
UI.crash!("Network timeout")

###### a deprecation message
UI.deprecated("The '--key' parameter is deprecated")
```

# Code of Conduct
Help us keep _pantograph_ open and inclusive. Please read and follow our [Code of Conduct](https://github.com/urbanquakers/pantograph/blob/master/CODE_OF_CONDUCT.md).

# License
This project is licensed under the terms of the MIT license. See the LICENSE file.
