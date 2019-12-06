{!docs/includes/setup-pantograph-header.md!}

# Other

Other advanced topics that didn't fit anywhere else:

# Environment Variables

You can define environment variables in a `.env` or `.env.default` file in the same directory as your `Pantfile`.
Environment variables are loaded using [dotenv](https://github.com/bkeepers/dotenv). Here's an example:

```shell
POM_PATH=pom.xml
ARTIFACTORY_API_TOKEN=your-artifactory-api-token
```

_pantograph_ also has a `--env` option that allows loading of environment specific `dotenv` files.
`.env` and `.env.default` will be loaded before environment specific `dotenv` files are loaded.
The naming convention for environment specific `dotenv` files is `.env.<environment>`

For example, `pantograph <lane-name> --env development` will load `.env`, `.env.default`, and `.env.development`

Alternatively, as environment variables are not a pantograph specific thing, you can also use standard methods to set them:

```shell
MY_USER='johnny@example.com' pantograph test
```

or

```shell
export MY_USER='johnny@example.com'
pantograph test
```

Although it kind of defeats the purpose of using them in the first place (not to have their content in any files), you can also set them in your `Pantfile`:

```ruby
ENV['MY_USER'] = 'johnny@example.com'
```
