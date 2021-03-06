# Testing _pantograph_

## Testing your local changes

### Checking it all

The `Pantfile` included at the top of the pantograph project allows you to run several validation steps, such as automated tests, code style and more.

```
bundle exec pantograph test
```

You can also run those steps independently or on a more fine grained way.

### Automated tests

Make sure to run the automated tests using `bundle exec` to ensure you’re running the correct version of `rspec` and `rubocop`

#### All unit tests

First, navigate into the root of the _pantograph_ project and run all unit tests using

```
bundle exec rspec
```

#### Unit tests for one specific tool

If you want to run tests only for one tool, use

```
bundle exec rspec [tool_name]
```

#### Unit tests in one specific test file

If you know exactly which `_spec.rb` file you want to run, use

```
bundle exec rspec ./pantograph/spec/pantograph_require_spec.rb
```

Replace `./pantograph/spec/pantograph_require_spec.rb` with the path of your test file of course.

#### Specific unit test (group) in a specific test file

If you know the specific unit test or unit test group you want to run, use

```
bundle exec rspec ./pantograph/spec/pantograph_require_spec.rb:17
```

The number is the line number of the unit test (`it ... do`) or unit test group (`describe ... do`) you want to run.

Instead of using the line number you can also use a filter with the `it "something", now: true` notation and then use `bundle exec rspec -t now` to run this tagged test. (Note that `now` can be any random string of your choice.)

### Code style

To verify and auto-fix the code style

```
bundle exec rubocop -a
```

If you want to run code style verification only for one tool, use `bundle exec rubocop -a [tool_name]`

<!-- Make sure that this section is the same as the one in `ToolsAndDebugging.md` -->

## Test your local _pantograph_ code base with your setup

After introducing some changes to the _pantograph_ source code, you probably want to test the changes for your application. The easiest way to do so it use [bundler](https://bundler.io/).

Edit your `Gemfile` in your project's root folder and replace the `gem 'pantograph'` line with:

```
gemspec path: File.expand_path("<PATH_TO_YOUR_LOCAL_PANTOGRAPH_CLONE>")
```

If you don't have a `Gemfile` yet, copy the `Gemfile` [.assets/Gemfile](.assets/Gemfile) from your local _pantograph_ clone and drop it into your project's root folder.

Make sure to replace `<PATH_TO_YOUR_LOCAL_PANTOGRAPH_CLONE>` with the path to your _pantograph_ clone, e.g. `~/pantograph`, then you can run

```
bundle update
```

in your project’s root directory. After doing so, you can verify you’re using the local version by running

```
bundle show pantograph
```

which should print out the path to your local development environment.

From now on, every time you introduce a change to your local _pantograph_ code base, you can immediately test it by running `bundle exec pantograph …`. (Note that just using `pantograph …` without `bundle exec` will **not** use your local _pantograph_ code base!)

If you want to run a command with your normal _pantograph_ installation, simply do not run the command with the `bundle exec` prefix.

To fully remove your local _pantograph_ from your local project again, delete the `Gemfile` you created above or remove the adaptions you did to match the `Gemfile` template.
