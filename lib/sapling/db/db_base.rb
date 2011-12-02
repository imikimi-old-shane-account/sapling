module Sapling
module DB

  class DBBase
    class Feature
      def initialize(users=[],percentage=0)
        self.percentage = percentage
        self.users = users
      end

      def percentage_active
        (user.id % 100) < percentage
      end

      def active?(user)
        individually_active(user) || percentage_active(user)
      end
    end
  end

end
end
