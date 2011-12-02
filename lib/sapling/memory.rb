module Sapling
  class Memory < Base

    class Feature < Base::Feature
      attr_accessor :users,:percentage

      def initialize(users=[],percentage=0)
        @users={}
        super
      end

      def individually_active(user)
        users[user.id]
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

    attr_accessor :features

    def initialize
      @features={}
    end

    def active?(feature,user)
      (f = features[feature]) && f.active?(user)
    end

    def activate_feature(feature)
      features[feature]||=Feature.new
    end

    def activate_user(feature, user)
      activate_feature(feature).activate_user(user)
    end

    def deactivate_user(feature, user)
      (f=features[feature]) && f.deactivate_user(user)
    end

    def activate_percentage(feature, percentage)
      activate_feature(feature).activate_percentage(percentage)
    end

    def deactivate_percentage(feature)
      activate_feature(feature).deactivate_percentage
    end
  end
end
