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
  gem.homepage      = "https://sunitparekh.github.com/data-anonymization"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency('activerecord', '~> 3.2.7')
  gem.add_dependency('activesupport', '~> 3.2.7')
  gem.add_dependency('faker', '~> 1.0.1')

end
