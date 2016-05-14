# coding: utf-8
require './lib/playstationnetwork/version'

Gem::Specification.new do |spec|
  spec.name          = "playstationnetwork-api"
  spec.version       = PlayStationNetwork::VERSION
  spec.authors       = ["Vlad Radulescu"]
  spec.email         = ["pacMakaveli90@gmail.co.uk"]

  spec.summary       = %q{A Ruby wrapper for Studio51's PlayStation Network API}
  spec.description   = %q{A Ruby wrapper for Studio51's PlayStation Network API for grabbing User profiles, Games and Trophies}
  spec.homepage      = ''
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty'
  spec.add_dependency 'json'
  spec.add_dependency 'activesupport'
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
