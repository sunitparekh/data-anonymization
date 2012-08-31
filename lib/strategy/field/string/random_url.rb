module DataAnon
  module Strategy
    module Field
      class RandomUrl

        def anonymize field
          length = Random.new.rand 5...15
          randomized_url = "http://#{DataAnon::Utils::RandomString.generate(length)}.#{DataAnon::Utils::RandomString.generate(3)}"
          randomized_url
        end
      end
    end
  end
end