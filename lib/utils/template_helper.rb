module DataAnon
  module Utils
    class TemplateHelper

      def self.source_connection_specs_rdbms config_hash

        config_hash.keys.reject{|key| config_hash[key].nil? }.collect { |key|
          if ((config_hash[key].class.to_s.downcase == 'string'))
            ":#{key} => '#{config_hash[key]}'"
          elsif ((config_hash[key].class.to_s.downcase == 'integer'))
            ":#{key} => #{config_hash[key]}"
          elsif ((config_hash[key].class.to_s.downcase == 'fixnum'))
            ":#{key} => #{config_hash[key]}"
          end
        }.join ', '

      end

      def self.destination_connection_specs_rdbms config_hash

        config_hash.keys.collect { |key|
          ":#{key} => '<enter_value>'"
        }.join ', '

      end

      def self.source_connection_specs_mongo config_hash
        ":mongodb_uri => '#{self.mongo_uri config_hash}', :database => '#{config_hash[:database]}'"
      end

      def self.destination_connection_specs_mongo
        ":mongodb_uri => '<enter value>', :database => '<enter value>'"
      end

      def self.mongo_uri config_hash
        if config_hash[:user].nil?
          mongo_uri = "mongodb://#{config_hash[:host]}#{config_hash[:port].nil? ? "" : ":#{config_hash[:port]}"}/#{config_hash[:database]}"
        else
          credentials = "#{config_hash[:username]}:#{config_hash[:password]}"
          mongo_uri = "mongodb://#{config_hash[:host]}#{config_hash[:port].nil? ? "" : ":#{config_hash[:port]}"}@#{credentials}/#{config_hash[:database]}"
        end
        mongo_uri
      end
    end
  end
end