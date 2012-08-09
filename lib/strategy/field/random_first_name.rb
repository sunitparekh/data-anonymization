module DataAnon
  module Strategy
    module Field

      class RandomFirstName

        def initialize

        end

        def anonymize field

          project_home =  File.join(File.dirname(__FILE__), '../../../')
          name_list = File.read("#{project_home}resources/first_names.txt").split
          size = name_list.size

          return name_list[rand(size)]
        end
      end
    end
  end
end