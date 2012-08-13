require 'active_record'
require 'logger'

module DataAnon
  module Utils

    class MassAssignmentIgnoreSanitizer < ActiveModel::MassAssignmentSecurity::Sanitizer
      def process_removed_attributes(attrs)
      end
    end

    class TempDatabase < ActiveRecord::Base
      self.abstract_class = true
    end

    class SourceDatabase < ActiveRecord::Base
      self.abstract_class = true
    end

    class DestinationDatabase < ActiveRecord::Base
      self.abstract_class = true
    end

    class BaseTable

      def self.create_table table_name, primary_key, database
        Class.new(database) do
          self.table_name = table_name
          self.primary_key = primary_key
          self.mass_assignment_sanitizer = MassAssignmentIgnoreSanitizer.new(self)
        end
      end

    end

    class SourceTable < BaseTable

      def self.create table_name, primary_key = nil
        create_table table_name, primary_key, SourceDatabase
      end

    end

    class DestinationTable < BaseTable

      def self.create table_name, primary_key = nil
        create_table table_name, primary_key, DestinationDatabase
      end

    end

  end
end