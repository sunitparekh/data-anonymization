module DataAnon
  module Strategy
    module Field


      class UserNameTemplate

        def initialize template
          @template = template
        end

        def anonymize field
          context = field.instance_eval { binding }
          eval ('"' + @template + '"'), context
        end

      end


    end
  end
end