# Tooling and Debugging

For detailed instructions on how to get started with contributing to _pantograph_, first check out [YourFirstPR.md][first-pr]
and [Testing.md](Testing.md). This guide will focus on more advanced instructions on how to debug _pantograph_ issues and work on patches.

## Debug using [pry](http://pryrepl.org/)

Before you’re able to use [pry](http://pryrepl.org/), make sure to have completed the [YourFirstPR.md][first-pr] setup part, as this will install all required development dependencies.

To add a breakpoint anywhere in the _pantograph_ codebase, add the following 2 lines wherever you want to jump in

```ruby
require 'pry'
binding.pry
```

As debugging with pry requires the development dependencies, make sure to execute _pantograph_ using `bundle exec` after
running `bundle install` in the project- or _pantograph_ directory.

```shell
bundle exec pantograph beta --verbose
```

If you need the breakpoint when running tests, make sure to have the `DEBUG` environment variable set,
as the default test runner will remove all output from stdout, and therefore not showing the output of `pry`:

```shell
DEBUG=1 bundle exec rspec
```

You will then jump into an interactive debugger that allows you to print out variables,
call methods and [much more](https://github.com/pry/pry/wiki).
To continue running the original script use `control` + `d`

<!--Links-->
[first-pr]: YourFirstPR.md
