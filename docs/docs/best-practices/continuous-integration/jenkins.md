# Jenkins Integration

## Installation

The recommended way to install [Jenkins](http://jenkins-ci.org/) is through [homebrew](http://brew.sh/):

```shell
brew update && brew install jenkins
```

From now on start `Jenkins` by running:

```shell
jenkins
```

## Ruby Environment
We recommend using [homebrew](http://brew.sh/) for installing Ruby,
though [rbenv](https://github.com/rbenv/rbenv) and [rvm](https://rvm.io/) work fine too.

If using a Gemfile in your project, add an "Execute shell" step as your first build step and call `bundle install`.

## Plugins

You'll find the following Jenkins plugins to be useful:

- **[AnsiColor Plugin](https://wiki.jenkins-ci.org/display/JENKINS/AnsiColor+Plugin):** Used to show the coloured output of the pantograph tools.
Don’t forget to enable `Color ANSI Console Output` in the `Build Environment` or your project.
- **[Rebuild Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Rebuild+Plugin):** This plugin will save you a lot of time.

## Build Step

Add an "Execute shell" build step using your appropriate _pantograph_ command per the example below:

```shell
pantograph deploy

# if using a Gemfile, prefix that command with `bundle exec`
bundle exec pantograph deploy
```

Replace `deploy` with the lane you want to use.


### commit_version_bump || git_commit

You can use `commit_version_bump` or `git_commit` action to commit changes to your repository in your pantograph setup.
**warning** When you are using webhooks to trigger your build on a push this will cause an infinite loop of triggering builds.

#### Gitlab

When you are using Gitlab you will need the [GitLab Plugin](https://wiki.jenkins-ci.org/display/JENKINS/GitLab+Plugin).
Inside the job you want to configure you go to `Build Triggers > Build when a change is pushed to GitLab > Enable [ci-skip]`.
When you include `[ci-skip]` in your build this commit won't trigger the build in jenkins at all.

**Example** 
 
```ruby
build_number = increment_build_number
commit_version_bump(message:"[ci-skip] Version Bump to #{build_number}")

git_commit(
    path:"./CHANGELOG.md",
    message:"[ci-skip] Updated CHANGELOG for Build #{build_number}"
)

push_to_git_remote
```

## Test Results and Screenshots

To show the **deployment result** right in `Jenkins`

- *Add post-build action*
- *Publish JUnit test result report*
- *Test report XMLs*: `pantograph/report.xml`

Save and run. The result should look like this:

![/img/best-practices/JenkinsIntegration.png](/img/best-practices/JenkinsIntegration.png)
