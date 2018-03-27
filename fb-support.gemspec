# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fb/support/version'

Gem::Specification.new do |spec|
  spec.name          = 'fb-support'
  spec.version       = Fb::Support::VERSION
  spec.authors       = ['Claudio Baccigalupo', 'Aaron Dao']
  spec.email         = ['claudio@fullscreen.net', 'hdao61@gmail.com']

  spec.summary       = %q{Support utilities for Fb gems}
  spec.description   = %q{Fb::Support provides common functionality to Fb,
    Fb::Auth. It is considered suitable for internal use only at this time.}
  spec.homepage      = 'https://github.com/fullscreen/fb-support'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 2.2.2'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'coveralls', '~> 0.8.20'
  spec.add_development_dependency 'pry-nav', '~> 0.2.4'
  spec.add_development_dependency 'yard', '~> 0.9.12'
end
