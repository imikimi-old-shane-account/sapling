module Sapling
  class Base
    class Feature
      def initialize(users=[],percentage=0)
        self.percentage = percentage
        users.each {|u| activate_user(u)}
      end

      def percentage_active?(user)
        Sapling::Base.percentage_active?(user,percentage)
      end

      def active?(user)
        individually_active?(user) || percentage_active?(user)
      end
    end

    class << self
      def percentage_active?(obj,percent)
        val = if obj.kind_of?(Integer)
          obj
        else
          # else assume user record
          obj.id
        end
        (val % 100) < percent
      end
    end
  end
end
