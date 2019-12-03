{!docs/includes/setup-pantograph-header.md!}

# Pantfile

The `Pantfile` stores the automation configuration that can be run with _pantograph_.

The `Pantfile` has to be inside your `./pantograph` directory.

# Importing another Pantfile

Within your `Pantfile` you can import another `Pantfile` using 2 methods:

## `import`

Import a `Pantfile` from a local path

```ruby
import "../GeneralPantfile"

override_lane :from_general do
  # ...
end
```

## `import_from_git`

Import from another git repository, which you can use to have one git repo with a default `Pantfile` for all your project


```ruby
import_from_git(url: 'https://github.com/pantograph/pantograph')
# or
import_from_git(url: 'git@github.com:MyAwesomeRepo/MyAwesomePantographStandardSetup.git',
               path: 'pantograph/Pantfile')

lane :new_main_lane do
  # ...
end
```

This will also automatically import all the local actions from this repo.

## Note

You should import the other `Pantfile` on the top above your lane declarations. When defining a new lane _pantograph_ will make sure to not run into any name conflicts. If you want to overwrite an existing lane (from the imported one), use the `override_lane` keyword.

# Load own actions from external folder

Add this to the top of your `Pantfile`.

```ruby
actions_path '../custom_actions_folder/'
```

# Using pantograph_require

If you're using a third party gem in your `Pantfile`, it is recommended to use `pantograph_require` instead of `require`. `pantograph_require` will:

- Verify the gem is installed
- Show installation instructions if not installed
- Require the gem (like `require` does)

## Example

```rb
pantograph_require 'hike'

lane :release do
  # Do stuff with hike
end
```