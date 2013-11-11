# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubyidescat/version'

Gem::Specification.new do |spec|
  spec.name          = "rubyidescat"
  spec.version       = Rubyidescat::VERSION
  spec.authors       = ["Joan Roig Arderiu"]
  spec.email         = ["roigarderiu@gmail.com"]
  spec.description   = %q{Wrapper for the Idescat API}
  spec.summary       = %q{Wrapper for the Idescat API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_dependency "httparty"
end
