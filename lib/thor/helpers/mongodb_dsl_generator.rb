require 'mongo'

module DataAnon
  module ThorHelpers
    class MongoDBDSLGenerator

      def initialize mongodb_uri, database, whitelist_patterns = [/^_/,/_at$/]
        @mongodb_uri = mongodb_uri
        @database = database
        @whitelist_patterns = whitelist_patterns
      end

      def generate
        db = Mongo::Connection.from_uri(@mongodb_uri)[@database]
        collections = db.collections
        collections.each do |collection|
          unless collection.name.start_with?('system.')
            depth = 1
            puts "collection '#{collection.name}' do"
            document = collection.find_one
            process_document(depth, document)
            puts "end"
          end
        end
      end

      def process_document(depth, document)
        return if document.nil?
        document.each do |key, value|
          print "\t"*depth
          if value.kind_of?(Hash)
            puts "document '#{key}'"
            process_document depth+1, value
          elsif value.kind_of?(Array) && value[0].kind_of?(Hash)
            puts "collection '#{key}'"
            process_document depth+1, value[0]
          elsif @whitelist_patterns.collect { |pattern| key.match(pattern) }.compact.length > 0
            puts "whitelist '#{key}'"
          elsif
            puts "anonymize '#{key}'"
          end
        end
      end

    end
  end
end

