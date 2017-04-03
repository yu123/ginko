# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ginko/version'

Gem::Specification.new do |spec|
  spec.name          = 'ginko'
  spec.version       = Ginko::VERSION
  spec.authors       = ['yu123']
  spec.email         = ['yu123.rb@gmail.com']

  spec.summary       = 'ruby library for Japanse bank code and branch code'
  spec.description   = 'ruby library for Japanse bank code and branch code'
  spec.homepage      = 'https://gihub.com/yu123/ginko'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
