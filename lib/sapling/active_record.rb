module Sapling
  class ActiveRecord < Base

    def table_name
      ActiveRecordModel.table_name
    end

    # returns hash of all features
    #   keys are feature names (symbols)
    #   values are:
    #     :percentage => nil or 0-100
    #     :user_ids => [] or array of user_ids (integers)
    def features
      @features ||= ActiveRecordModel.find(:all).inject({}) do |ret,feature|
        name = feature.feature.to_sym
        ret[name]||=Feature.new(name)
        ret[name].percentage ||= feature.percentage
        ret[name].users[feature.user_id]=true if feature.user_id
        ret
      end
    end

    def reload
      @features=nil
      true
    end

    module AdminAPI

      def activate_user(feature, user)
        ActiveRecordModel.transaction do
          deactivate_user(feature, user)
          ActiveRecordModel.create(:feature => feature.to_s, :user_id => user.id)
        end
        reload
      end

      def deactivate_user(feature, user)
        ActiveRecordModel.delete_all ["feature = ? AND percentage IS NULL and user_id = ?",feature.to_s,user.id]
        reload
      end

      def activate_percentage(feature, percentage)
        raise "invalid percentage #{percentage.inspect}" unless percentage.kind_of?(Integer) && percentage>=0 && percentage<=100
        ActiveRecordModel.transaction do
          deactivate_percentage(feature)
          ActiveRecordModel.create(:feature => feature.to_s, :percentage => percentage)
        end
        reload
      end

      def deactivate_percentage(feature)
        ActiveRecordModel.delete_all ["feature = ? AND percentage IS NOT NULL AND user_id IS NULL",
          feature.to_s
        ]
        reload
      end
    end

    include AdminAPI
  end
end
