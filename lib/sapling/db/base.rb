module Sapling::DB
  class Base
    class Feature
      def initialize(users=[],percentage=0)
        self.percentage = percentage
        users.each {|u| activate_user(u)}
      end

      def percentage_active(user)
        (user.id % 100) < percentage
      end

      def active?(user)
        individually_active(user) || percentage_active(user)
      end
    end
  end
end
