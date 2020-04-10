# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |gem|
  gem.name          = 'data-anonymization'
  gem.version       = DataAnonymization::VERSION
  gem.authors       = ['Sunit Parekh', 'Anand Agrawal', 'Satyam Agarwala']
  gem.email         = %w(parekh.sunit@gmail.com anand.agrawal84@gmail.com satyamag@gmail.com)
  gem.description   = %q{Data anonymization tool for RDBMS and MongoDB databases}
  gem.summary       = %q{Tool to create anonymized production data dump to use for performance and testing environments.}
  gem.homepage      = 'http://sunitparekh.github.com/data-anonymization'
  gem.license       = 'MIT'


  gem.files         = `git ls-files`.split($/).select { |f| !f.match(/^sample-data/) }
  gem.executables   = 'datanon'
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency('activerecord', '~> 6.0')
  gem.add_dependency('composite_primary_keys', '~> 12.0')
  gem.add_dependency('activesupport', '~> 6.0')
  gem.add_dependency('rgeo', '~> 1.0')
  gem.add_dependency('rgeo-geojson', '~> 2.0')
  gem.add_dependency('powerbar', '~> 1.0')
  gem.add_dependency('parallel', '~> 1.12')
  gem.add_dependency('thor', '~> 0.20.3')
end
