<style type="text/css">
  .pantograph-setup {
    border-left: .4rem solid #00b0ff;
    border-bottom: .1rem solid rgba(0,176,255,.1);
    background-color: rgba(0,176,255,.1);
    padding: 15px;
    margin-bottom: 20px;
    font-weight: 200;
  }
  .pantograph-setup-wrapper {
    background-color: rgba(0,176,255,.05);
  }
  .pantograph-setup-wrapper[open] {
    padding-bottom: 1px;
  }
  .pantograph-setup-header {
    font-size: 20px;
    font-weight: 500;
  }
  .pantograph-setup-more-details {
    font-size: 18px;
    font-weight: 350;
  }
</style>

<details class="pantograph-setup-wrapper">
  <summary class="pantograph-setup">New to pantograph? Click here to open the installation & setup instructions first</summary>
  

<p class="pantograph-setup-header">1) Install the latest Xcode command line tools</p>

```no-highlight
xcode-select --install
```

<p class="pantograph-setup-header">2) Install <i>pantograph</i></p>

```sh
# Using RubyGems
sudo gem install pantograph -NV

# Alternatively using Homebrew
brew cask install pantograph
```

<p class="pantograph-setup-header">3) Navigate to your project and run</p>

```no-highlight
pantograph init
```

<p class="pantograph-setup-more-details"><a href="/getting-started/ios/setup/">More Details</a></p>

</details>
