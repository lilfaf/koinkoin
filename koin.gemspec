# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'koin/version'

Gem::Specification.new do |spec|
  spec.name          = "koin"
  spec.version       = Koin::VERSION
  spec.authors       = ["Louis Larpin"]
  spec.email         = ["louis.larpin@gmail.com"]
  spec.summary       = ""
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "puma"
  spec.add_dependency "sinatra"
  spec.add_dependency "dotenv"
  spec.add_dependency "dotenv-deployment"
  spec.add_dependency "omniauth"
  spec.add_dependency "omniauth-facebook"
  spec.add_dependency "sidekiq"
  spec.add_dependency "redis"
  spec.add_dependency "whenever"
  spec.add_dependency "koala"
  spec.add_dependency "foreman"
  spec.add_dependency "dropbox-sdk"
  spec.add_dependency "capistrano"
  spec.add_dependency "capistrano-rvm"
  spec.add_dependency "capistrano-bundler"
  spec.add_dependency "capistrano-sidekiq"
  spec.add_dependency "capistrano3-puma"
end
