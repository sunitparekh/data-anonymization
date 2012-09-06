module DataAnon
  module Utils
    class TemplateHelper

      def self.source_connection_specs config_hash

        config_hash.keys.reject{|key| config_hash[key].nil? }.collect { |key|
          if ((config_hash[key].class.to_s.downcase == "string"))
            ":#{key} => '#{config_hash[key]}'"
          elsif ((config_hash[key].class.to_s.downcase == "fixnum"))
            ":#{key} => #{config_hash[key]}"
          end
        }.join ', '

      end

      def self.destination_connection_specs config_hash

        config_hash.keys.collect { |key|
          ":#{key} => '<enter_value>'"
        }.join ', '

      end

    end
  end
end