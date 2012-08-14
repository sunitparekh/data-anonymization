module DataAnon
  module Strategy
    module Field
      class GmailTemplate

        def initialize username = 'someusername'
          @username = username
        end

        def anonymize field
          "#{@username}+#{field.row_number}@gmail.com"
        end
      end
    end
  end
end