module Sapling
  class ActiveRecord < Base

    def table_name
      Model.table_name
    end

    module ClientAPI
      # see Sapling::API::Client
      def active?(feature, options={})
        options = Util.normalized_options options
        v =Model.count(:conditions => [
          "feature = ? AND ((user_id IS NOT NULL AND user_id = ?) OR (percentage IS NOT NULL AND ? < percentage)) ",
          feature,
          (u=options[:user]) && u.id,
          ((c=options[:context_id]) && c%100) || 100
        ])
        v > 0
      end
    end
    include ClientAPI

    module AdminAPI

      def activate_user(feature, user)
        Model.transaction do
          deactivate_user(feature, user)
          Model.create(:feature => feature, :user_id => user.id)
        end
      end

      def deactivate_user(feature, user)
        Model.delete_all ["feature = ? AND percentage IS NULL and user_id = ?",feature,user.id]
      end

      def activate_percentage(feature, percentage)
        raise "invalid percentage #{percentage.inspect}" unless percentage.kind_of?(Integer) && percentage>=0 && percentage<=100
        Model.transaction do
          deactivate_percentage(feature)
          Model.create(:feature => feature, :percentage => percentage)
        end
      end

      def deactivate_percentage(feature)
        Model.delete_all ["feature = ? AND percentage IS NOT NULL AND user_id IS NULL",
          feature
        ]
      end
    end

    include AdminAPI
  end
end
