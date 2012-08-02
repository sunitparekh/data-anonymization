require 'active_record'

module Utils

  class BaseTable

    def self.create table_name, primary_key
      Class.new(ActiveRecord::Base) do
        self.table_name = table_name
        self.primary_key = primary_key
      end
    end

  end

end