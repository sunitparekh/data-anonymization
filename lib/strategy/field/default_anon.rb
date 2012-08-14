module DataAnon
  module Strategy
    module Field

      class DefaultAnon

        DEFAULT_STRATEGIES = {:string => FieldStrategy::LoremIpsum.new,
                              :integer => FieldStrategy::RandomIntegerDelta.new(5),
                              :float => FieldStrategy::RandomFloatDelta.new(5.0),
                              :datetime => FieldStrategy::DateTimeDelta.new,
                              :time => FieldStrategy::TimeDelta.new,
                              :date => FieldStrategy::DateDelta.new,
                              :boolean => FieldStrategy::RandomBoolean.new
        }

        def initialize user_defaults
          @user_defaults = DEFAULT_STRATEGIES.merge user_defaults
        end

        def anonymize field
          strategy = @user_defaults[field.value.class.to_s.downcase.to_sym] || FieldStrategy::Whitelist.new
          strategy.anonymize field
        end

      end


    end
  end
end