# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-memair/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Greg Clarke"]
  gem.email         = ["greg@gho.st"]
  gem.description   = %q{Official OmniAuth strategy for Memair.}
  gem.summary       = %q{Official OmniAuth strategy for Memair.}
  gem.homepage      = "https://github.com/memair/omniauth-memair"
  gem.license       = "MIT"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.name          = "omniauth-memair"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Memair::VERSION

  gem.add_dependency 'omniauth', '~> 1.5'
  gem.add_dependency 'omniauth-oauth2', '>= 1.4.0', '< 2.0'
  gem.add_dependency 'memair', '0.0.27'
  gem.add_development_dependency 'rspec', '~> 3.5'
end
