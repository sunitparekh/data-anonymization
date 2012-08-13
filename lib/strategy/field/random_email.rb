module DataAnon
  module Strategy
    module Field

      class RandomEmail

        TLDS = ['com','org','net','edu','gov','mil','biz','info']


        def initialize hostname = nil, tld = nil
          @hostname = hostname
          @tld = tld
          @string_util = DataAnon::Utils::StringUtils.new
          @number_util = DataAnon::Utils::NumberUtils.new
        end

        def anonymize field

          username_length = @number_util.generate_random_int(5,15)
          host_name_length = @number_util.generate_random_int(2,10)

          username = @string_util.generate_random_string(username_length)
          hostname = @hostname || @string_util.generate_random_string(host_name_length)
          tld = @tld || TLDS[rand(TLDS.length)]

          return username + "@" + hostname + "." + tld

        end
      end
    end

  end
end