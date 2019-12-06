# pantograph keys

This guide will show you the best ways to store and use your keys and sensitive secrets for services like Crashlytics, Slack, etc.

# In your Pantfile

```ruby
lane :notify do
  slack(slack_url: 'https://hooks.slack.com/services/T03NA19Q5/...')
end
```

or if you want to only define the keys once and use it multiple times


```ruby
ENV['SLACK_URL'] = 'https://hooks.slack.com/services/T03NA19Q5/...'

lane :notify do
  slack
end
```

This is the most straight forward and easiest solution, but might cause a few issues:

- If you ever decide to open source your application you'll have to make sure to remove the keys from your git history
- If your keys got invalidated for whatever reason and you decide to rollback your code base to an earlier stage the keys will also be rolled back

To get the name of the available environment variables, run `pantograph action [action_name]`.

# Bash Profile

To not store your keys in `git`, you can pass all parameters of all actions using environment variables.

You can edit your `~/.bash_profile` to include something like

```shell
export SLACK_URL='https://hooks.slack.com/services/T03NA19Q5/...'
```

If you use a different shell (e.g. `zshell`) you'll need to edit `~/.zshrc` instead.

After editing the `.bash_profile` you need to either re-open your terminal session or run `source ~/.bash_profile`.

**Disadvantages**

- Every terminal tool you run gets access to your environment variables. 
- You have to edit your bash profile on every computer you want to run _pantograph_ from
- The bash profile isn't automatically loaded by some CI-systems like Jenkins

To get the name of the available environment variables, run `pantograph action [action_name]`.

# [dotenv](https://github.com/bkeepers/dotenv)

[dotenv](https://github.com/bkeepers/dotenv) is a system to store your environment in a file that is project specific. Basically you have a hidden file in your project containing all the environment variables for your project.

You can store a default configuration in `.env.default` which will be loaded by _pantograph_ automatically.

```shell
SLACK_URL="https://hooks.slack.com/services/T03NA19Q5/..."
```

You might want different configurations depending on your environment.

```shell
pantograph notify --env development
```

and store the configuration in `.env.development` with all keys for the development environment.

Install `gem install dotenv` or add `dotenv` to your `Gemfile`.
More information about the [recommended way to install gems](https://johnknapprs.github.io/pantograph/getting-started/ios/setup/#use-a-gemfile).

To get the name of the available environment variables, run `pantograph action [action_name]`.
