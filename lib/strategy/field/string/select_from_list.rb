module DataAnon
  module Strategy
    module Field

      # Select randomly one of the values specified.
      #
      #    !!!ruby
      #    anonymize('State').using FieldStrategy::SelectFromList.new(['New York','Georgia',...])
      #
      #    !!!ruby
      #    anonymize('NameTitle').using FieldStrategy::SelectFromList.new(['Mr','Mrs','Dr',...])
      #

      class SelectFromList < SelectFromFile

        def initialize values
          @values = values.class == Array ? values : [values]
        end

      end


    end
  end
end