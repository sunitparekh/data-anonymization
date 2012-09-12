require 'thor'
require 'active_record'
require 'erb'

module DataAnon
  module ThorHelpers
    class RDBMSDSLGenerator

      def self.source_root
        File.dirname(__FILE__)
      end

      def generate_whitelist_script(configuration_hash)

        @configuration_hash = configuration_hash
        @ar_object = ActiveRecord::Base.establish_connection(@configuration_hash)

        @tables = @ar_object.connection.tables

        erb = ERB.new( File.new(RDBMSDSLGenerator.source_root + "/../templates/whitelist_template.erb").read, nil, '-')

        File.open('rdbms_whitelist_generated.rb', 'w') do |f|
          f.write erb.result(binding)
          f.close
        end

      rescue Mysql2::Error => e
        puts "\e[31mActiverecord was unable to establish a connection to the specified database. Please check the configuration options and try again.\e[0m"
        puts e.backtrace
      end

    end
  end
end


