# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'owldiff/version'

Gem::Specification.new do |spec|
  spec.name          = "owldiff"
  spec.version       = Owldiff::VERSION
  spec.authors       = ["Andreas Knöpfle"]
  spec.email         = ["andreas.knoepfle@gmail.com"]
  spec.licenses    = ['LGPL-3.0']
  spec.summary       = %q{A client library for the owldiff-service.}
  spec.description   = %q{This is the client library for the owldiff-service server. This library takes the HOST, PORT and two URLs of ontology files and returns a diff between those ontologies.}
  spec.homepage      = "https://github.com/andreasknoeplfe/owldiff"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "mocha", "~> 1.1"
  spec.add_development_dependency "minitest", "~> 4.7"
  spec.add_development_dependency "simplecov", "~> 0.9"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.4"
end
