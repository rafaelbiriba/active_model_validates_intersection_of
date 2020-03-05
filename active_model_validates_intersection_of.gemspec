# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "active_model_validates_intersection_of/version"

Gem::Specification.new do |spec|
  spec.name          = "active_model_validates_intersection_of"
  spec.version       = ActiveModelValidatesIntersectionOf::VERSION
  spec.authors       = ["Rafael Biriba"]
  spec.email         = ["biribarj@gmail.com"]

  spec.summary       = "A custom validation for your Active Model that check if an array is included in another one"
  spec.description   = "A custom validation for your Active Model that check if an array is included in another one"
  spec.homepage      = "https://github.com/rafaelbiriba/active_model_validates_intersection_of"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel", ">= 5.0.0"
  spec.add_development_dependency "bundler", "~> 2.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "simplecov"
end
