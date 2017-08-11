# coding: utf-8
require './lib/playstationnetwork/version'

Gem::Specification.new do |spec|
  spec.name          = 'playstationnetwork-api'
  spec.version       = PlayStationNetwork::VERSION
  spec.authors       = ['Vlad Radulescu']
  spec.email         = ['vlad@games.directory']

  spec.summary       = %q{ A Ruby wrapper for PSN Leaderboard API }
  spec.description   = %q{ A Ruby wrapper around PSN Leaderboard's API for grabbing Users, Games and Trophies }
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'httparty', '~> 0.15.6'
  spec.add_development_dependency 'bundler', '~> 1.15.3'
  spec.add_development_dependency 'rake', '~> 12.0.0'
  spec.add_development_dependency 'rspec', '~> 3.6.0'
end
