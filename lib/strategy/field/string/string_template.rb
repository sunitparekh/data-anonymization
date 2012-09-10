module DataAnon
  module Strategy
    module Field

      # Simple string evaluation within [DataAnon::Core::Field](#dataanon-core-field) context. Can be used for email, username anonymization.
      # Make sure to put the string in 'single quote' else it will get evaluated inline.
      #
      #    !!!ruby
      #    anonymize('UserName').using FieldStrategy::StringTemplate.new('user#{row_number}')
      #
      #    !!!ruby
      #    anonymize('Email').using FieldStrategy::StringTemplate.new('valid.address+#{row_number}@gmail.com')
      #
      #    !!!ruby
      #    anonymize('Email').using FieldStrategy::StringTemplate.new('useremail#{row_number}@mailinator.com')

      class StringTemplate

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