module DataAnon
  module Strategy
    module Field
      class GmailTemplate

        def initialize gmail_address = nil
          @gmail_address = gmail_address
        end

        def anonymize field
          username = @gmail_address[0,@gmail_address.index('@')]
          "#{username}+#{field.row_number}@gmail.com"
        end
      end
    end
  end
end