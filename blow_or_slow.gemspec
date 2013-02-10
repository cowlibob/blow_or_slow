# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'blow_or_slow/version'

Gem::Specification.new do |gem|
  gem.name          = "blow_or_slow"
  gem.version       = BlowOrSlow::VERSION
  gem.authors       = ["James Cowlishaw"]
  gem.email         = ["james@cowlibob.co.uk"]
  gem.description   = %q{Scrapes weather observations from weatherbase.com, returning wind direction & strength}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rest-client", "~> 1.6.7"
  gem.add_dependency "nokogiri", "~> 1.5.6"
  gem.add_development_dependency "webmock", "~> 1.9.0"
  gem.add_development_dependency "rspec", "~> 2.12"
  gem.add_development_dependency "ephemeral_response", "~> 0.4.0"
end
