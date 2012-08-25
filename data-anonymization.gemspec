# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'version'

Gem::Specification.new do |gem|
  gem.name          = "data-anonymization"
  gem.version       = DataAnonymization::VERSION
  gem.authors       = ["Sunit Parekh", "Anand Agrawal", "Satyam Agarwala"]
  gem.email         = ["parekh.sunit@gmail.com","anand.agrawal84@gmail.com", "satyamag@gmail.com"]
  gem.description   = %q{Data anonymization tool for RDBMS databases}
  gem.summary       = %q{Tool to create anonymized production data dump to use for PREF and other TEST environments.}
  gem.homepage      = "http://sunitparekh.github.com/data-anonymization"

  gem.files         = `git ls-files`.split($/).select { |f| !f.match(/^sample-data/) }
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('activerecord', '~> 3.2.8')
  gem.add_dependency('composite_primary_keys', '~> 5.0.8')
  gem.add_dependency('activesupport', '~> 3.2.8')
  gem.add_dependency('rgeo', '~> 0.3.15')
  gem.add_dependency('rgeo-geojson', '~> 0.2.3')
  gem.add_dependency('powerbar', '~> 1.0.8')
  gem.add_dependency('parallel', '~> 0.5.18')
end
