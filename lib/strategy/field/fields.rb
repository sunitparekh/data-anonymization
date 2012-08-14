require 'strategy/field/whitelist'
require 'strategy/field/random_boolean'
require 'strategy/field/anonymous'

# string
require 'strategy/field/string/lorem_ipsum'
require 'strategy/field/string/string_template'
require 'strategy/field/string/random_string'

require 'strategy/field/string/select_from_file'
require 'strategy/field/string/select_from_list'
require 'strategy/field/string/distinct_column_values'

# number
require 'strategy/field/number/random_integer'
require 'strategy/field/number/random_integer_delta'
require 'strategy/field/number/random_float_delta'

# contact
require 'strategy/field/contact/random_phone_number'

# datetime
require 'strategy/field/datetime/anonymize_time'
require 'strategy/field/datetime/anonymize_datetime'
require 'strategy/field/datetime/anonymize_date'
require 'strategy/field/datetime/date_time_delta'
require 'strategy/field/datetime/time_delta'
require 'strategy/field/datetime/date_delta'

# email
require 'strategy/field/email/random_email'
require 'strategy/field/email/gmail_template'
require 'strategy/field/email/random_mailinator_email'

# name
require 'strategy/field/name/random_first_name'
require 'strategy/field/name/random_last_name'
require 'strategy/field/name/random_full_name'
require 'strategy/field/name/random_user_name'



FieldStrategy = DataAnon::Strategy::Field

require 'strategy/field/default_anon'

