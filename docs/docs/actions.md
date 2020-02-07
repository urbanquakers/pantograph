<!--
This file is auto-generated and will be re-generated every time the docs are updated.
To modify it, go to its source at https://github.com/urbanquakers/pantograph/blob/master/pantograph/lib/assets/Actions.md.erb
-->

{!docs/includes/setup-pantograph-header.md!}

# pantograph actions

This page contains a list of all built-in pantograph actions and their available options.

To get the most up-to-date information from the command line on your current version you can also run

```sh
pantograph actions # list all available pantograph actions
pantograph action [action_name] # more information for a specific action
```

You can import another `Pantfile` by using the `import` action. This is useful if you have shared lanes across multiple apps and you want to store a `Pantfile` in a separate folder. The path must be relative to the `Pantfile` this is called from.

```ruby
import './path/to/other/Pantfile'
```

For _pantograph_ plugins, check out the [available plugins](/plugins/available-plugins/) page.
If you want to create your own action, check out the [local actions](/create-action/#local-actions) page.

- [Testing](#testing)
- [Building](#building)
- [Documentation](#documentation)
- [Beta](#beta)
- [Push](#push)
- [Releasing your app](#releasing-your-app)
- [Source Control](#source-control)
- [Notifications](#notifications)
- [Misc](#misc)
- [Deprecated](#deprecated)
- [Plugins](/plugins/available-plugins/)


# Testing

Action | Description | Supported Platforms
---|---|---
<a href="/actions/sonar/">sonar</a> | Invokes sonar-scanner to programmatically run SonarQube analysis | mac, linux, windows



# Building

Action | Description | Supported Platforms
---|---|---
<a href="/actions/gradle/">gradle</a> | All gradle related actions, including building and testing your application | mac, linux, windows



# Documentation

Action | Description | Supported Platforms
---|---|---



# Beta

Action | Description | Supported Platforms
---|---|---



# Push

Action | Description | Supported Platforms
---|---|---



# Releasing your app

Action | Description | Supported Platforms
---|---|---



# Source Control

Action | Description | Supported Platforms
---|---|---
<a href="/actions/ensure_git_status_clean/">ensure_git_status_clean</a> | Raises error if there are uncommitted git changes | mac, linux, windows
<a href="/actions/git_branch/">git_branch</a> | Returns the name of the current git branch | mac, linux, windows
<a href="/actions/last_git_commit/">last_git_commit</a> | Return last git commit hash, abbreviated commit hash, commit message and author | mac, linux, windows
<a href="/actions/reset_git_repo/">reset_git_repo</a> | Resets git repo to a clean state by discarding uncommitted changes | mac, linux, windows
<a href="/actions/changelog_from_git_commits/">changelog_from_git_commits</a> | Collect git commit messages into a changelog | mac, linux, windows
<a href="/actions/number_of_commits/">number_of_commits</a> | Return the number of commits in current git branch | mac, linux, windows
<a href="/actions/git_pull/">git_pull</a> | Executes a simple git pull command | mac, linux, windows
<a href="/actions/push_to_git_remote/">push_to_git_remote</a> | Push local changes to the remote branch | mac, linux, windows
<a href="/actions/git_tag_exists/">git_tag_exists</a> | Checks if the git tag with the given name exists | mac, linux, windows
<a href="/actions/ensure_git_branch/">ensure_git_branch</a> | Raises an exception if not on a specific git branch | mac, linux, windows
<a href="/actions/git_commit/">git_commit</a> | Directly commit the given file with the given message | mac, linux, windows
<a href="/actions/push_git_tags/">push_git_tags</a> | Push local tags to the remote - this will only push tags | mac, linux, windows
<a href="/actions/danger/">danger</a> | Runs `danger` for the project | mac, linux, windows
<a href="/actions/set_github_release/">set_github_release</a> | This will create a new release on GitHub and upload assets for it | mac, linux, windows
<a href="/actions/create_pull_request/">create_pull_request</a> | This will create a new pull request on GitHub | mac, linux, windows
<a href="/actions/get_github_release/">get_github_release</a> | This will verify if a given release version is available on GitHub | mac, linux, windows
<a href="/actions/github_api/">github_api</a> | Call a GitHub API endpoint and get the resulting JSON response | mac, linux, windows
<a href="/actions/git_submodule_update/">git_submodule_update</a> | Execute git submodule command | mac, linux, windows
<a href="/actions/git_pull_tags/">git_pull_tags</a> | Executes a simple `git fetch --tags` command | mac, linux, windows



# Notifications

Action | Description | Supported Platforms
---|---|---
<a href="/actions/slack/">slack</a> | Send a success/error message to your [Slack](https://slack.com) group | mac, linux, windows
<a href="/actions/twitter/">twitter</a> | Post a tweet on [Twitter.com](https://twitter.com) | mac, linux, windows



# Misc

Action | Description | Supported Platforms
---|---|---
<a href="/actions/puts/">puts</a> | Prints out the given text | mac, linux, windows
<a href="/actions/default_platform/">default_platform</a> | Defines a default platform to not have to specify the platform | mac, linux, windows
<a href="/actions/pantograph_version/">pantograph_version</a> | Alias for the `min_pantograph_version` action | mac, linux, windows
<a href="/actions/lane_context/">lane_context</a> | Access lane context values | mac, linux, windows
<a href="/actions/import/">import</a> | Import another Pantfile to use its lanes | mac, linux, windows
<a href="/actions/import_from_git/">import_from_git</a> | Import another Pantfile from a remote git repository to use its lanes | mac, linux, windows
<a href="/actions/skip_docs/">skip_docs</a> | Skip the creation of the pantograph/README.md file when running pantograph | mac, linux, windows
<a href="/actions/is_ci/">is_ci</a> | Is the current run being executed on a CI system, like Jenkins or Travis | mac, linux, windows
<a href="/actions/update_pantograph/">update_pantograph</a> | Makes sure pantograph-tools are up-to-date when running pantograph | mac, linux, windows
<a href="/actions/bundle_install/">bundle_install</a> | This action runs `bundle install` (if available) | mac, linux, windows
<a href="/actions/prompt/">prompt</a> | Ask the user for a value or for confirmation | mac, linux, windows
<a href="/actions/say/">say</a> | This action speaks the given text out loud | mac, linux, windows
<a href="/actions/zip/">zip</a> | Compress a file or folder to a zip | mac, linux, windows
<a href="/actions/artifactory/">artifactory</a> | This action uploads an artifact to artifactory | mac, linux, windows
<a href="/actions/erb/">erb</a> | Allows to Generate output files based on ERB templates | mac, linux, windows
<a href="/actions/download/">download</a> | Download a file from a remote server (e.g. JSON file) | mac, linux, windows
<a href="/actions/rocket/">rocket</a> | Outputs ascii-art for a rocket 🚀 | mac, linux, windows
<a href="/actions/debug/">debug</a> | Print out an overview of the lane context values | mac, linux, windows
<a href="/actions/ensure_no_debug_code/">ensure_no_debug_code</a> | Ensures the given text is nowhere in the code base | mac, linux, windows
<a href="/actions/cloc/">cloc</a> | Generates a Code Count that can be read by Jenkins (xml format) | mac
<a href="/actions/rsync/">rsync</a> | Rsync files from :source to :destination | mac, linux, windows
<a href="/actions/jira/">jira</a> | Leave a comment on JIRA tickets | mac, linux, windows
<a href="/actions/ssh/">ssh</a> | Allows remote command execution using ssh | mac, linux, windows
<a href="/actions/min_pantograph_version/">min_pantograph_version</a> | Verifies the minimum pantograph version required | mac, linux, windows
<a href="/actions/println/">println</a> | Alias for the `puts` action | mac, linux, windows
<a href="/actions/ensure_bundle_exec/">ensure_bundle_exec</a> | Raises an exception if not using `bundle exec` to run pantograph | mac, linux, windows
<a href="/actions/ruby_version/">ruby_version</a> | Verifies the minimum ruby version required | mac, linux, windows
<a href="/actions/prompt_secure/">prompt_secure</a> | Ask the user for a value or for confirmation | mac, linux, windows
<a href="/actions/is_verbose/">is_verbose</a> | Returns Boolean whether `--verbose` flag was set | mac, linux, windows
<a href="/actions/sh/">sh</a> | Runs a shell command | mac, linux, windows
<a href="/actions/ensure_env_vars/">ensure_env_vars</a> | Raises an exception if the specified env vars are not set | mac, linux, windows
<a href="/actions/plugin_scores/">plugin_scores</a> | [31mNo description provided[0m | mac, linux, windows
<a href="/actions/echo/">echo</a> | Alias for the `puts` action | mac, linux, windows
<a href="/actions/opt_out_usage/">opt_out_usage</a> | This will stop uploading the information which actions were run | mac, linux, windows



# Deprecated

Action | Description | Supported Platforms
---|---|---



