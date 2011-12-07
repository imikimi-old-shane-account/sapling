module Sapling
  class Memory < Base

    class Feature
      attr_accessor :users,:percentage

      def initialize
        @users={}
        self.percentage = 0
      end

      # see Sapling::API::Client
      def active?(options={})
        options = Util::normalized_options(options)
        individually_active?(options[:user]) || percentage_active?(options)
      end

      def percentage_active?(options={})
        (Util.context_id(options) % 100) < percentage
      end

      def individually_active?(user)
        user && users[user.id]
      end

      def activate_user(user)
        users[user.id]=true
      end

      def deactivate_user(user)
        users.delete(user.id)
      end

      def activate_percentage(percentage)
        @percentage=percentage
      end

      def deactivate_percentage
        @percentage=0
      end
    end

    def initialize
      @features={}
    end

    module ClientAPI
      # see Sapling::API::Client
      def active?(feature, options={})
        options = Util::normalized_options(options)
        (f = @features[feature]) && f.active?(options)
      end

      def features
        @features.keys.sort_by {|k| k.to_s}
      end

      # see Sapling::API::Client
      def active_features(options={})
        features.select {|feature| active?(feature,options)}
      end
    end

    module AdminAPI
      def activate_feature(feature)
        @features[feature]||=Feature.new
      end

      def activate_user(feature, user)
        activate_feature(feature).activate_user(user)
      end

      def deactivate_user(feature, user)
        (f=@features[feature]) && f.deactivate_user(user)
      end

      def activate_percentage(feature, percentage)
        activate_feature(feature).activate_percentage(percentage)
      end

      def deactivate_percentage(feature)
        activate_feature(feature).deactivate_percentage
      end
    end

    include ClientAPI
    include AdminAPI
  end
end
