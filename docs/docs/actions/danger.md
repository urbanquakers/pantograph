<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/danger.rb
-->

# danger


Runs `danger` for the project




> Stop Saying your Forgot in Source Control<br>More information: [https://github.com/danger/danger](https://github.com/danger/danger).


danger ||
---|---
Supported platforms | mac, linux, windows
Author | @KrauseFx, @urbanquakers



## 2 Examples

```ruby
danger
```

```ruby
danger(
  danger_id: "unit-tests",
  dangerfile: "tests/MyOtherDangerFile",
  github_api_token: ENV["GITHUB_API_TOKEN"],
  verbose: true
)
```





## Parameters

Key | Description | Default
----|-------------|--------
  `use_bundle_exec` | Use bundle exec when there is a Gemfile presented | `true`
  `verbose` | Show more debugging information | `false`
  `danger_id` | The identifier of this Danger instance | 
  `dangerfile` | The location of your Dangerfile | `Dangerfile`
  `github_api_token` | GitHub API token for danger | 
  `fail_on_errors` | Should always fail the build process, defaults to false | `false`
  `new_comment` | Makes Danger post a new comment instead of editing its previous one | `false`
  `remove_previous_comments` | Makes Danger remove all previous comment and create a new one in the end of the list | `false`
  `base` | A branch/tag/commit to use as the base of the diff. [master\|dev\|stable] | 
  `head` | A branch/tag/commit to use as the head. [master\|dev\|stable] | 
  `pr` | Run danger on a specific pull request. e.g. \"https://github.com/danger/danger/pull/518\" | 

<em id="parameters-legend-dynamic">* = default value is dependent on the user's system</em>


<hr />



## Documentation

To show the documentation in your terminal, run
```shell
pantograph action danger
```

<hr />

## CLI

It is recommended to add the above action into your `Pantfile`, however sometimes you might want to run one-offs. To do so, you can run the following command from your terminal

```shell
pantograph run danger
```

To pass parameters, make use of the `:` symbol, for example

```shell
pantograph run danger parameter1:"value1" parameter2:"value2"
```

It's important to note that the CLI supports primitive types like integers, floats, booleans, and strings. Arrays can be passed as a comma delimited string (e.g. `param:"1,2,3"`). Hashes are not currently supported.

It is recommended to add all _pantograph_ actions you use to your `Pantfile`.

<hr />

## Source code

This action, just like the rest of _pantograph_, is fully open source, <a href="https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/pantograph/actions/danger.rb" target="_blank">view the source code on GitHub</a>

<hr />

<a href="/actions/"><b>Back to actions</b></a>
