module DataAnon
  module Strategy
    module Field

      # Generates a valid unique gmail address by taking advantage of the gmail + strategy. Takes in a valid gmail username and
      # generates emails of the form username+<number>@gmail.com
      #
      #    !!!ruby
      #    anonymize('Email').using FieldStrategy::GmailTemplate.new('username')
      #

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