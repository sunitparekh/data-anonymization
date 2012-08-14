module DataAnon
  module Strategy
    module Field

      class RandomEmail

        TLDS = ['com','org','net','edu','gov','mil','biz','info']


        def initialize hostname = nil, tld = nil
          @hostname = hostname
          @tld = tld
        end

        def anonymize field

          username_length = DataAnon::Utils::RandomInt.generate(5,15)
          host_name_length = DataAnon::Utils::RandomInt.generate(2,10)

          username = DataAnon::Utils::RandomString.generate(username_length)
          hostname = @hostname || DataAnon::Utils::RandomString.generate(host_name_length)
          tld = @tld || TLDS[rand(TLDS.length)]

          return username + "@" + hostname + "." + tld

        end
      end
    end

  end
end