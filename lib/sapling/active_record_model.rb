require "active_record"
class Sapling::ActiveRecordModel < ::ActiveRecord::Base
  set_table_name "sapling_settings"

  #structure:
  # feature varchar(255),
  # percentage integer, -- 0 to 100 or NULL
  # user_id integer -- user's ID or NULL
end
