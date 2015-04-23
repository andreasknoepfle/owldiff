# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'owldiff/version'

Gem::Specification.new do |spec|
  spec.name          = "owldiff"
  spec.version       = Owldiff::VERSION
  spec.authors       = ["Andreas Knöpfle"]
  spec.email         = ["andreas.knoepfle@gmail.com"]

  spec.summary       = %q{A client library for the owldiff-service.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 4.7.3"
  spec.add_development_dependency "simplecov", "~> 0.9.2"
end
