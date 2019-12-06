Install the latest Xcode command line tools:

```shell
xcode-select --install
```

Install _pantograph_ using

```shell
# Install ruby via homebrew (macOS & linux only)
brew install ruby

# Set ruby in your shell path (example uses Zsh)
echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.zshrc

# Using RubyGems
gem install pantograph
```

<!-- # Alternatively using Homebrew
brew cask install pantograph -->