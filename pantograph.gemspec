# coding: utf-8

lib = File.expand_path('../pantograph/lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pantograph/version'

# Copy over the latest .rubocop.yml style guide
require 'yaml'
rubocop_config = File.expand_path('../.rubocop.yml', __FILE__)
config = YAML.safe_load(open(rubocop_config))
config.delete('require')
File.write("#{lib}/pantograph/plugins/template/.rubocop.yml", YAML.dump(config))

Gem::Specification.new do |spec|
  spec.name          = 'pantograph'
  spec.version       = Pantograph::VERSION
  # list of authors is regenerated and resorted on each release
  spec.authors       = ['John Knapp']

  spec.email         = ['knappj2@gmail.com']
  spec.summary       = Pantograph::SUMMARY
  spec.description   = Pantograph::DESCRIPTION
  spec.homepage      = 'https://johnknapprs.github.io/pantograph/'
  spec.license       = 'MIT'
  spec.metadata      = {
    'docs_url' => 'https://johnknapprs.github.io/pantograph'
  }

  spec.required_ruby_version = '>= 2.0.0'

  spec.files = Dir.glob('*/lib/**/*', File::FNM_DOTMATCH) + Dir['bin/*'] + Dir['*/README.md'] + %w(README.md LICENSE .yardopts) - Dir['pantograph/lib/pantograph/actions/docs/assets/*']
  spec.bindir = 'bin'
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }

  # spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = Dir['*/lib']

  spec.add_dependency('slack-notifier', '>= 2.0.0', '< 3.0.0') # Slack notifications
  spec.add_dependency('terminal-table', '>= 1.4.5', '< 2.0.0') # Actions documentation
  spec.add_dependency('plist', '>= 3.1.0', '< 4.0.0') # Needed for set_build_number_repository and get_info_plist_value actions
  spec.add_dependency('addressable', '>= 2.3', '< 3.0.0') # Support for URI templates
  spec.add_dependency('word_wrap', '~> 1.0.0') # to add line breaks for tables with long strings
  spec.add_dependency('danger', '~>6.1.0')

  # TTY dependencies
  spec.add_dependency('tty-screen', '>= 0.6.3', '< 1.0.0') # detect the terminal width
  spec.add_dependency('tty-spinner', '>= 0.8.0', '< 1.0.0') # loading indicators

  spec.add_dependency('colored', '~> 1.2') # colored terminal output
  spec.add_dependency('commander-fastlane', '>= 4.4.6', '< 5.0.0') # CLI parser
  spec.add_dependency('excon', '>= 0.45.0', '< 1.0.0') # Great HTTP Client
  spec.add_dependency('faraday', '< 0.16.0') # Used for deploygate, hockey and testfairy actions
  spec.add_dependency('faraday_middleware', '< 0.16.0') # same as faraday
  spec.add_dependency('faraday-cookie_jar', '~> 0.0.6')
  spec.add_dependency('gh_inspector', '>= 1.1.2', '< 2.0.0') # search for issues on GitHub when something goes wrong
  spec.add_dependency('highline', '>= 1.7.2', '< 2.0.0') # user inputs (e.g. passwords)
  spec.add_dependency('json', '< 3.0.0') # Because sometimes it's just not installed
  spec.add_dependency('mini_magick', '>= 4.9.4', '< 5.0.0') # To open, edit and export PSD files
  spec.add_dependency('dotenv', '>= 2.1.1', '< 3.0.0')
  spec.add_dependency('bundler', '>= 1.12.0', '< 3.0.0') # Used for pantograph plugins
  spec.add_dependency('emoji_regex', '>= 0.1', '< 2.0') # Used to scan for Emoji in the changelog

  # Development only
  spec.add_development_dependency('rake', '< 12')
  spec.add_development_dependency('rspec', '~> 3.5.0')
  spec.add_development_dependency('rspec_junit_formatter', '~> 0.2.3')
  spec.add_development_dependency('pry', '~> 0.12.2')
  spec.add_development_dependency('pry-byebug', '~> 3.7.0')
  spec.add_development_dependency('pry-rescue', '~> 1.5.0')
  spec.add_development_dependency('pry-stack_explorer', '~> 0.4.9.3')
  spec.add_development_dependency('yard', '~> 0.9.11')
  spec.add_development_dependency('webmock', '~> 2.3.2')
  spec.add_development_dependency('coveralls', '~> 0.8.13')
  spec.add_development_dependency('rubocop', Pantograph::RUBOCOP_REQUIREMENT)
  spec.add_development_dependency('rubocop-require_tools', '~> 0.1', '>= 0.1.2')
  spec.add_development_dependency('rb-readline', '~> 0.5.5') # https://github.com/deivid-rodriguez/byebug/issues/289#issuecomment-251383465
  spec.add_development_dependency('rest-client', '~> 1.8', '>= 1.8.0')
  spec.add_development_dependency('fakefs', '~> 0.8.1')
  spec.add_development_dependency('sinatra', '~> 1.4.8')
  spec.add_development_dependency('climate_control', '~> 0.2.0')
end
