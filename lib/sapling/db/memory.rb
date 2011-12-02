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
    end

    attr_accessor :features

    def initialize
      @features={}
    end

    def active?(feature,user)
      (f = features[feature]) && f.active?(user)
    end

    def activate_user(feature, user)
      if f=features[feature]
        f.activate_user(user)
      else
        features[feature]=Feature.new([user])
      end
    end

    def deactivate_user(feature, user)
      (f=features[feature]) && f.deactivate_user(user)
    end

  end
end
