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
- [Push](#push)
- [Source Control](#source-control)
- [Notifications](#notifications)
- [Misc](#misc)
- [Deprecated](#deprecated)
- [Plugins](/plugins/available-plugins/)


# Testing

Action | Description | Supported Platforms
---|---|---
<a href="/actions/sonar/">sonar</a> | Invokes sonar-scanner to programmatically run SonarQube analysis | ios, android, mac



# Building

Action | Description | Supported Platforms
---|---|---
<a href="/actions/gradle/">gradle</a> | All gradle related actions, including building and testing your Android app | ios, android

# Screenshots

Action | Description | Supported Platforms
---|---|---



# Project

Action | Description | Supported Platforms
---|---|---
<a href="/actions/get_build_number/">get_build_number</a> | Get the build number of your project | ios, mac



# Code_signing

Action | Description | Supported Platforms
---|---|---



# Documentation

Action | Description | Supported Platforms
---|---|---
<a href="/actions/jazzy/">jazzy</a> | Generate docs using Jazzy | ios, mac



# Beta

Action | Description | Supported Platforms
---|---|---
<a href="/actions/nexus_upload/">nexus_upload</a> | Upload a file to [Sonatype Nexus platform](https://www.sonatype.com) | ios, android, mac



# Push

Action | Description | Supported Platforms
---|---|---



# Releasing your app

Action | Description | Supported Platforms
---|---|---



# Source Control

Action | Description | Supported Platforms
---|---|---
<a href="/actions/ensure_git_status_clean/">ensure_git_status_clean</a> | Raises an exception if there are uncommitted git changes | ios, android, mac
<a href="/actions/git_branch/">git_branch</a> | Returns the name of the current git branch, possibly as managed by CI ENV vars | ios, android, mac
<a href="/actions/last_git_commit/">last_git_commit</a> | Return last git commit hash, abbreviated commit hash, commit message and author | ios, android, mac
<a href="/actions/reset_git_repo/">reset_git_repo</a> | Resets git repo to a clean state by discarding uncommitted changes | ios, android, mac
<a href="/actions/changelog_from_git_commits/">changelog_from_git_commits</a> | Collect git commit messages into a changelog | ios, android, mac
<a href="/actions/number_of_commits/">number_of_commits</a> | Return the number of commits in current git branch | ios, android, mac
<a href="/actions/git_pull/">git_pull</a> | Executes a simple git pull command | ios, android, mac
<a href="/actions/last_git_tag/">last_git_tag</a> | Get the most recent git tag | ios, android, mac
<a href="/actions/push_to_git_remote/">push_to_git_remote</a> | Push local changes to the remote branch | ios, android, mac
<a href="/actions/add_git_tag/">add_git_tag</a> | This will add an annotated git tag to the current branch | ios, android, mac
<a href="/actions/commit_version_bump/">commit_version_bump</a> | Creates a 'Version Bump' commit. Run after `increment_build_number` | ios, mac
<a href="/actions/git_tag_exists/">git_tag_exists</a> | Checks if the git tag with the given name exists in the current repo | ios, android, mac
<a href="/actions/ensure_git_branch/">ensure_git_branch</a> | Raises an exception if not on a specific git branch | ios, android, mac
<a href="/actions/git_commit/">git_commit</a> | Directly commit the given file with the given message | ios, android, mac
<a href="/actions/push_git_tags/">push_git_tags</a> | Push local tags to the remote - this will only push tags | ios, android, mac
<a href="/actions/git_add/">git_add</a> | Directly add the given file or all files | ios, android, mac
<a href="/actions/get_build_number_repository/">get_build_number_repository</a> | Get the build number from the current repository | ios, mac
<a href="/actions/set_github_release/">set_github_release</a> | This will create a new release on GitHub and upload assets for it | ios, android, mac
<a href="/actions/create_pull_request/">create_pull_request</a> | This will create a new pull request on GitHub | ios, android, mac
<a href="/actions/get_github_release/">get_github_release</a> | This will verify if a given release version is available on GitHub | ios, android, mac
<a href="/actions/github_api/">github_api</a> | Call a GitHub API endpoint and get the resulting JSON response | ios, android, mac
<a href="/actions/git_submodule_update/">git_submodule_update</a> | Executes a git submodule command | ios, android, mac
<a href="/actions/commit_github_file/">commit_github_file</a> | This will commit a file directly on GitHub via the API | ios, android, mac



# Notifications

Action | Description | Supported Platforms
---|---|---
<a href="/actions/slack/">slack</a> | Send a success/error message to your [Slack](https://slack.com) group | ios, android, mac
<a href="/actions/notification/">notification</a> | Display a macOS notification with custom message and title | ios, android, mac
<a href="/actions/hipchat/">hipchat</a> | Send a error/success message to [HipChat](https://www.hipchat.com/) | ios, android, mac
<a href="/actions/mailgun/">mailgun</a> | Send a success/error message to an email group | ios, android, mac
<a href="/actions/chatwork/">chatwork</a> | Send a success/error message to [ChatWork](https://go.chatwork.com/) | ios, android, mac
<a href="/actions/ifttt/">ifttt</a> | Connect to the [IFTTT Maker Channel](https://ifttt.com/maker) | ios, android, mac
<a href="/actions/twitter/">twitter</a> | Post a tweet on [Twitter.com](https://twitter.com) | ios, android, mac
<a href="/actions/typetalk/">typetalk</a> | Post a message to [Typetalk](https://www.typetalk.com/) | ios, android, mac



# App_store_connect

Action | Description | Supported Platforms
---|---|---



# Misc

Action | Description | Supported Platforms
---|---|---
<a href="/actions/puts/">puts</a> | Prints out the given text | ios, android, mac
<a href="/actions/default_platform/">default_platform</a> | Defines a default platform to not have to specify the platform | ios, android, mac
<a href="/actions/pantograph_version/">pantograph_version</a> | Alias for the `min_pantograph_version` action | ios, android, mac
<a href="/actions/lane_context/">lane_context</a> | Access lane context values | ios, android, mac
<a href="/actions/import/">import</a> | Import another Pantfile to use its lanes | ios, android, mac
<a href="/actions/import_from_git/">import_from_git</a> | Import another Pantfile from a remote git repository to use its lanes | ios, android, mac
<a href="/actions/skip_docs/">skip_docs</a> | Skip the creation of the pantograph/README.md file when running pantograph | ios, android, mac
<a href="/actions/is_ci/">is_ci</a> | Is the current run being executed on a CI system, like Jenkins or Travis | ios, android, mac
<a href="/actions/unlock_keychain/">unlock_keychain</a> | Unlock a keychain | ios, android, mac
<a href="/actions/update_pantograph/">update_pantograph</a> | Makes sure pantograph-tools are up-to-date when running pantograph | ios, android, mac
<a href="/actions/bundle_install/">bundle_install</a> | This action runs `bundle install` (if available) | ios, android, mac
<a href="/actions/create_keychain/">create_keychain</a> | Create a new Keychain | ios, android, mac
<a href="/actions/delete_keychain/">delete_keychain</a> | Delete keychains and remove them from the search list | ios, android, mac
<a href="/actions/backup_file/">backup_file</a> | This action backs up your file to "[path].back" | ios, android, mac
<a href="/actions/prompt/">prompt</a> | Ask the user for a value or for confirmation | ios, android, mac
<a href="/actions/restore_file/">restore_file</a> | This action restore your file that was backuped with the `backup_file` action | ios, android, mac
<a href="/actions/say/">say</a> | This action speaks the given text out loud | ios, android, mac
<a href="/actions/zip/">zip</a> | Compress a file or folder to a zip | ios, android, mac
<a href="/actions/danger/">danger</a> | Runs `danger` for the project | ios, android, mac
<a href="/actions/artifactory/">artifactory</a> | This action uploads an artifact to artifactory | ios, android, mac
<a href="/actions/erb/">erb</a> | Allows to Generate output files based on ERB templates | ios, android, mac
<a href="/actions/download/">download</a> | Download a file from a remote server (e.g. JSON file) | ios, android, mac
<a href="/actions/rocket/">rocket</a> | Outputs ascii-art for a rocket 🚀 | ios, android, mac
<a href="/actions/debug/">debug</a> | Print out an overview of the lane context values | ios, android, mac
<a href="/actions/make_changelog_from_jenkins/">make_changelog_from_jenkins</a> | Generate a changelog using the Changes section from the current Jenkins build | ios, android, mac
<a href="/actions/ensure_no_debug_code/">ensure_no_debug_code</a> | Ensures the given text is nowhere in the code base | ios, android, mac
<a href="/actions/cloc/">cloc</a> | Generates a Code Count that can be read by Jenkins (xml format) | ios, mac
<a href="/actions/scp/">scp</a> | Transfer files via SCP | ios, android, mac
<a href="/actions/rsync/">rsync</a> | Rsync files from :source to :destination | ios, android, mac
<a href="/actions/dotgpg_environment/">dotgpg_environment</a> | Reads in production secrets set in a dotgpg file and puts them in ENV | ios, android, mac
<a href="/actions/jira/">jira</a> | Leave a comment on JIRA tickets | ios, android, mac
<a href="/actions/ssh/">ssh</a> | Allows remote command execution using ssh | ios, android, mac
<a href="/actions/add_extra_platforms/">add_extra_platforms</a> | Modify the default list of supported platforms | ios, android, mac
<a href="/actions/clipboard/">clipboard</a> | Copies a given string into the clipboard. Works only on macOS | ios, android, mac
<a href="/actions/build_and_upload_to_appetize/">build_and_upload_to_appetize</a> | Generate and upload an ipa file to appetize.io | ios
<a href="/actions/sh/">sh</a> | Runs a shell command | ios, android, mac
<a href="/actions/min_pantograph_version/">min_pantograph_version</a> | Verifies the minimum pantograph version required | ios, android, mac
<a href="/actions/spaceship_logs/">spaceship_logs</a> | Find, print, and copy Spaceship logs | ios, android, mac
<a href="/actions/echo/">echo</a> | Alias for the `puts` action | ios, android, mac
<a href="/actions/println/">println</a> | Alias for the `puts` action | ios, android, mac
<a href="/actions/plugin_scores/">plugin_scores</a> | [31mNo description provided[0m | ios, android, mac
<a href="/actions/ensure_env_vars/">ensure_env_vars</a> | Raises an exception if the specified env vars are not set | ios, android, mac
<a href="/actions/ruby_version/">ruby_version</a> | Verifies the minimum ruby version required | ios, android, mac
<a href="/actions/ensure_bundle_exec/">ensure_bundle_exec</a> | Raises an exception if not using `bundle exec` to run pantograph | ios, android, mac
<a href="/actions/opt_out_usage/">opt_out_usage</a> | This will stop uploading the information which actions were run | ios, android, mac



# Deprecated

Action | Description | Supported Platforms
---|---|---



