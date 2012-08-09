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

          username_length = rand 5...15
          host_name_length = rand 2...10

          username = rand(36**username_length).to_s(36)
          hostname = @hostname || rand(36**host_name_length).to_s(36)
          tld = @tld || TLDS[rand(TLDS.length)]

          return username + "@" + hostname + "." + tld

        end
      end
    end

  end
end