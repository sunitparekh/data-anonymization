require 'erb'
require 'thor'

module DataAnon
  module ThorHelpers
    class MongoDBDSLGenerator

      def self.source_root
        File.dirname(__FILE__)
      end

      def initialize(configuration_hash, whitelist_patterns)
        @mongodb_uri = DataAnon::Utils::TemplateHelper.mongo_uri(configuration_hash)
        @whitelist_patterns = whitelist_patterns || [/^_/,/_at$/,/_id$/,/_type$/]
        @configuration_hash = configuration_hash
        @output = []
      end

      def generate

        db = Mongo::Client.new(@mongodb_uri, :database => @configuration_hash[:database])
        collections = db.collections
        collections.each do |collection|
          unless collection.name.start_with?('system.')
            depth = 2
            @output << "\tcollection '#{collection.name}' do"
            document = collection.find({}).first
            process_document(depth, document)
            @output << "\tend\n"
          end
        end

        erb = ERB.new( File.new(RDBMSDSLGenerator.source_root + "/../templates/mongodb_whitelist_template.erb").read, nil, '-')
        File.open('mongodb_whitelist_generated.rb', 'w') do |f|
          f.write erb.result(binding)
          f.close
        end

      end

      def process_document(depth, document)
        return if document.nil?
        document.each do |key, value|
          @output << ("\t"*depth)
          if value.kind_of?(Hash)
            end_statement = @output[-1]+"end"
            @output[-1] << "document '#{key}' do"
            process_document depth+1, value
            @output << end_statement
          elsif value.kind_of?(Array) && value[0].kind_of?(Hash)
            end_statement = @output[-1]+"end"
            @output[-1] << "collection '#{key}' do"
            process_document depth+1, value[0]
            @output << end_statement
          elsif @whitelist_patterns.collect { |pattern| key.match(pattern) }.compact.length > 0
            @output[-1] << "whitelist '#{key}'"
          elsif
            @output[-1] << "anonymize '#{key}'"
          end
        end
      end

    end
  end
end
