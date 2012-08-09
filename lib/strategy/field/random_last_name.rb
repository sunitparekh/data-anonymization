module DataAnon
  module Strategy
    module Field

      class RandomLastName

        def initialize

        end

        def anonymize field

          project_home =  File.join(File.dirname(__FILE__), '../../../')
          name_list = File.read("#{project_home}resources/last_names.txt").split
          size = name_list.size

          return name_list[rand(size)]
        end
      end
    end
  end
end