module DataAnon
  module Strategy
    module Field

      class DefaultAnon

        FS = DataAnon::Strategy::Field
        DEFAULT_STRATEGIES = {:string => FS::LoremIpsum.new,
                              :integer => FS::RandomInt.new(18,70)
        }

        def initialize user_defaults
          @default_strategies = DEFAULT_STRATEGIES.merge user_defaults
        end

        def anonymize field
          strategy = @default_strategies[field.value.class.to_s.downcase.to_sym] || FS::Whitelist.new
          strategy.anonymize field
        end

      end


    end
  end
end