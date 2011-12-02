
module Sapling
module DB
  class Memory < DBBase

    class Feature < DBBase::Feature
      attr_accessor :users,:percentage

      def individually_active(user)
        users[user]
      end
    end

    def initialize
      @features={}
    end

    def active?(feature,user)
      (f = features[feature]) && f.active?(user)
    end

  end
end
end
