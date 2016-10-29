require 'active_record'
require 'composite_primary_keys'
require 'logger'

module DataAnon
  module Utils

    class TempDatabase < ActiveRecord::Base
      self.abstract_class = true
    end

    class DisableReferentialIntegrityDatabase < ActiveRecord::Base
      self.abstract_class = true
    end

    class SourceDatabase < ActiveRecord::Base
      self.abstract_class = true
    end

    class DestinationDatabase < ActiveRecord::Base
      self.abstract_class = true
    end

    class BaseTable

      def self.create_table  database, table_name, primary_keys = []
        klass_name = table_name.to_s.downcase.capitalize
        return database.const_get klass_name if database.const_defined? klass_name
        database.const_set(klass_name, Class.new(database) do
            self.table_name = table_name
            self.primary_keys = primary_keys if primary_keys.length > 1
            self.primary_key = primary_keys[0] if primary_keys.length == 1
            self.primary_key = nil if primary_keys.length == 0
            self.inheritance_column = :_type_disabled
          end
        )
      end

    end

    class SourceTable < BaseTable

      def self.create table_name, primary_key = []
        create_table  SourceDatabase, table_name, primary_key
      end

    end

    class DestinationTable < BaseTable

      def self.create table_name, primary_key = []
        create_table DestinationDatabase, table_name, primary_key
      end

    end

  end
end