# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xmlenc/version'

Gem::Specification.new do |spec|
  spec.name          = "xmlenc"
  spec.version       = Xmlenc::VERSION
  spec.authors       = ["Benoist"]
  spec.email         = ["bclaassen@digidentity.eu"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", "~> 1.6"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec-core", "~> 2.14"
  spec.add_development_dependency "rake"
end
