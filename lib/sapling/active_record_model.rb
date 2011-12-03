require "active_record"
module Sapling
  class ActiveRecord < Base
    class Model < ::ActiveRecord::Base
      set_table_name "sapling_settings"
    end
  end
end
