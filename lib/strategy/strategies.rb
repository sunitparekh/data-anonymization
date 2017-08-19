require 'strategy/base'
require 'strategy/whitelist'
require 'strategy/blacklist'
require 'strategy/field/fields'

begin
  require 'mongo'
  require 'strategy/mongodb/anonymize_field'
  require 'strategy/mongodb/whitelist'
  require 'strategy/mongodb/blacklist'
rescue LoadError
  'Ignoring the mongodb specific libraries if monog driver is not specified in gem'
end
