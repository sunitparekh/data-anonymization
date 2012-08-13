module DataAnon
  module Strategy
    module Field


      class RandomSelection

        def initialize values
          @values = values.class == Array ? values : [values]
          @number_util = DataAnon::Utils::NumberUtils.new
        end

        def anonymize field
          return @values[0] if @values.length == 1
          @values[@number_util.generate_random_int(0,(@values.length - 1))]
        end

      end


    end
  end
end