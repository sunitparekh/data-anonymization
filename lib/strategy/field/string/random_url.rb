module DataAnon
  module Strategy
    module Field

      # Generates a randomized URL while maintaining the structure of the original url
      #
      #    !!!ruby
      #    anonymize('fb_profile').using FieldStrategy::RandomURL.new

    class RandomUrl

        def anonymize field

          url = field.value
          randomized_url = ""
          protocols = url.scan(/http:\/\/|www\./)
          protocols.each do |token|
            url = url.gsub(token,"")
            randomized_url += token
          end

          marker_position = 0

          while marker_position < url.length
            special_char_index = url.index(/\W/, marker_position) || url.length
            text = url[marker_position...special_char_index]
            randomized_url += "#{DataAnon::Utils::RandomStringCharsOnly.generate(text.length)}#{url[special_char_index]}"
            marker_position = special_char_index + 1
          end

          randomized_url
        end
      end
    end
  end
end