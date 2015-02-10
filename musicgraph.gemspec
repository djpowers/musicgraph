# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'musicgraph/version'

Gem::Specification.new do |spec|
  spec.name          = "musicgraph"
  spec.version       = Musicgraph::VERSION
  spec.authors       = ["Dave Powers"]
  spec.email         = ["djpowers89@gmail.com"]
  spec.summary       = %q{Web service wrapper for MusicGraph API}
  spec.description   = %q{Web service wrapper for MusicGraph API}
  spec.homepage      = "https://github.com/djpowers/musicgraph"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"

  spec.add_dependency "faraday"
  spec.add_dependency "json"
end
