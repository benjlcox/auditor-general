# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'auditor-general/version'

Gem::Specification.new do |spec|
  spec.name          = "auditor-general"
  spec.version       = AuditorGeneral::VERSION
  spec.authors       = ["benjlcox"]
  spec.email         = ["ben@shopify.com"]
  spec.summary       = "Simple and explicit user action auditing for Rails"
  spec.description   = "Simple and explicit user action auditing for Rails"
  spec.homepage      = "https://github.com/Shopify/auditor-general"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 4.0.0"
  spec.add_dependency "sinatra", ">= 1.4.6"
  spec.add_dependency 'will_paginate', '~> 3.0.6'
  spec.add_dependency 'will_paginate-bootstrap', '~> 1.0.1'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"


end
