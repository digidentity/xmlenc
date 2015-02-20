# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xmlenc/version'

Gem::Specification.new do |spec|
  spec.name          = "xmlenc"
  spec.version       = Xmlenc::VERSION
  spec.authors       = ["Benoist"]
  spec.email         = ["bclaassen@digidentity.eu"]
  spec.description   = %q{A (partial)implementation of the XMLENC specificiation}
  spec.summary       = %q{A (partial)implementation of the XMLENC specificiation}
  spec.homepage      = "https://github.com/digidentity/xmlenc"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  if RUBY_VERSION < '1.9'
    spec.add_dependency "activesupport", "~> 3.0.0"
    spec.add_dependency "activemodel", "~> 3.0.0"
    spec.add_dependency "nokogiri", "~> 1.5.10"
  else
    spec.add_dependency "activesupport", ">= 3.0.0"
    spec.add_dependency "activemodel", ">= 3.0.0"
    spec.add_runtime_dependency('nokogiri', '~> 1.6.0')
  end
    
  spec.add_development_dependency "nokogiri-happymapper", '~> 0.5.7'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec-rails", "~> 2.14"
  spec.add_development_dependency "rake"
end
