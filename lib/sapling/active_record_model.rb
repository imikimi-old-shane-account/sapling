module Sapling
  class ActiveRecord
    class Model < ::ActiveRecord::Base
      set_table_name "sapling_settings"
    end
  end
end
