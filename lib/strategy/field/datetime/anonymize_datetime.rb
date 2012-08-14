module DataAnon
  module Strategy
    module Field

      class AnonymizeDateTime < AnonymizeTime

        private
        def create_object(year, month, day, hour, min, sec)
          DateTime.new(year, month, day, hour, min, sec)
        end

      end
    end
  end
end