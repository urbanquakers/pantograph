# FAQs

### I'm getting an SSL error

If your output contains something like

```shell
SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed
```

that usually means you are using an outdated version of OpenSSL. Make sure to install the latest one using [homebrew](http://brew.sh/).

```shell
brew update && brew upgrade openssl
```

### pantograph is slow (to start)

If you experience slow launch times of _pantograph_, there are 2 solutions to solve this problem:

##### Uninstall unused gems

```shell
[sudo] gem cleanup
```

### Error when running _pantograph_ with Jenkins

This is usually caused when running Jenkins as its own user. While this is possible, you'll have to take care of creating a temporary Keychain, filling it and then using it when building your application. 

For more information about the recommended setup with Jenkins open the [Jenkins Guide](/best-practices/continuous-integration/#jenkins-integration).

### Multiple targets of the same underlying app

If you have one code base, but multiple branded applications

Create different `.env` files for each environment

Example: Create a `.env.app1`, `.env.app2`, and `.env.app3`. Define each of these like the following...
```no-highlight
DLV_FIRST_NAME=Josh
DLV_LAST_NAME=Holtz
DLV_PRIM_CATG=Business
DLV_SCND_CATG=Games
```

Now your Pantfile file should look something like this:
```ruby
lane :build do 
  puts [
    first_name: ENV['DLV_FIRST_NAME'],
    last_name: ENV['DLV_LAST_NAME']
  ]

```

Now to run this, all you need to do is specify the environment argument when running _pantograph_ and it will pull from the `.env` file that matches the same name...
Ex: `pantograph build --env app1` will use `.env.app1`
Ex: `pantograph build --env app2` will use `.env.app2`

You can also references these environment variables almost anywhere in _pantograph_. 

You can even define a lane to perform actions on multiple targets:

```ruby
desc "Deploy both versions"
lane :deploy_all do
    sh "pantograph deploy --env paid"
    sh "pantograph deploy --env free"
end
```

And you can combine multiple envs in one go
Ex: `pantograph build --env app1,env1,env2` will use `.env.app1` `.env.env1` and `.env.env2`

More on the `.env` file can be found [here](https://github.com/bkeepers/dotenv).

### Disable colored output

Set the `PANTOGRAPH_DISABLE_COLORS` environment variable to disable ANSI colors (e.g. for CI machines)

```shell
export PANTOGRAPH_DISABLE_COLORS=1
```

### Enable tab auto complete for pantograph lane names

Supported shells: _bash_, _zsh_, _fish_.

```shell
pantograph enable_auto_complete
```

Follow the on screen prompt to add a line to your _bash_/_zsh_/_fish_ profile.

### "User interaction is not allowed" when using _pantograph_ via SSH

This error can occur when you run _pantograph_ via SSH. To fix it check out [this reply on StackOverflow](https://stackoverflow.com/a/22637896/445598).

### Some pantograph commands hang indefinitely or produce strange errors and symbols 

Make sure your `LC_ALL` and `LANG` variables are set up correctly. _pantograph_ requires an UTF-8 environment, so setting those variables to `en_US.UTF-8` should fix your issues.
