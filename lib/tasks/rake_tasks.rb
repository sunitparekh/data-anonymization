require 'rake'

module DataAnonymization
  class RakeTasks
    include Rake::DSL if defined? Rake::DSL

    def initialize
      desc 'Task to build the clean empty destination database'
      task :empty_dest do
        system 'rm sample-data/chinook-empty.sqlite'
        system 'sqlite3 sample-data/chinook-empty.sqlite < sample-data/chinook_schema.sql'
      end
    end


  end
end

