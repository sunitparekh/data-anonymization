require 'active_record'
require 'erb'
require 'data-anonymization'

class Anonymization < Thor
  include Thor::Actions

  def self.source_root
    File.dirname(__FILE__)
  end

  desc "generate_dsl", "Generates a base anonymization script using the whitelist strategy using the database schema"

  method_option :adapter, :required => true, :aliases => "-a", :desc => "Activerecord database adapter to be used [required]"
  method_option :host, :required => true, :aliases => "-h", :desc => "Source Database host [required]"
  method_option :database, :required => true, :aliases => "-d", :desc => "Database name [required]"
  method_option :port, :aliases => "-p", :desc => "Port to connect to. If not provided default port provided by AR will be used"
  method_option :username, :aliases => "-u", :desc => "Username"
  method_option :password, :aliases => "-pwd", :desc => "Password"

  def generate_dsl

    @configuration_hash = {:adapter => options["adapter"],
                           :host => options["host"],
                           :port => options["port"],
                           :database => options["database"],
                           :username => options["username"],
                           :password => options["password"]
                          }

    @ar_object = ActiveRecord::Base.establish_connection(@configuration_hash)

    @tables = @ar_object.connection.tables

    create_file "whitelist_generated.rb"
    erb = ERB.new( File.new("whitelist_template.erb").read, nil, '-')

    File.open('whitelist_generated.rb', 'w') do |f|
      f.write erb.result(binding)
    end

  end
end