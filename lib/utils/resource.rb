module DataAnon
  module Utils

    class Resource

      def self.file file_name
        project_home =  File.join(File.dirname(__FILE__), '../../')
        "#{project_home}resources/#{file_name}"
      end

      def self.project_home
        File.join(File.dirname(__FILE__), '../../')
      end
    end

  end
end