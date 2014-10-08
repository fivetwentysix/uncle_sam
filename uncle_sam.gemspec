# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uncle_sam/version'

Gem::Specification.new do |spec|
  spec.name          = "uncle_sam"
  spec.version       = UncleSam::VERSION
  spec.authors       = ["Patrick Ma"]
  spec.email         = ["fivetwentysix@gmail.com"]
  spec.summary       = %q{US tax calculator written in Ruby.}
  # spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "http://github.com/PatrickMa/uncle_sam"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "pry", "~> 0.10"
end
