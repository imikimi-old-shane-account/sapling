module Sapling
  class ActiveRecord < Base

    def table_name
      Model.table_name
    end

    private
    def query_conditions(feature,normalized_options={})
      ret=[
        "#{'feature = ? AND ' if feature} ((user_id IS NOT NULL AND user_id = ?) OR (percentage IS NOT NULL AND ? < percentage)) "
      ]
      ret<<feature if feature
      ret+=[
        (u=normalized_options[:user]) && u.id,
        ((c=normalized_options[:context_id]) && c%100) || 100
      ]
      ret
    end
    public

    module ClientAPI
      # see Sapling::API::Client
      def active?(feature, options={})
        options = Util.normalized_options options
        v = Model.count(:conditions => query_conditions(feature,options))
        v > 0
      end

      def features
        features = Model.find :all, :select => "feature", :group => "feature", :order => "feature"
        features.map {|record| record.feature.to_sym}
      end

      # returns a list of features enabled for a user
      # see Sapling::API::Client
      def active_features(options={})
        options = Util.normalized_options options
        features = Model.find :all, :conditions => query_conditions(nil,options)
        features.map {|record| record.feature.to_sym}.uniq
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
