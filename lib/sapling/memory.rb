module Sapling
  class Memory < Base

    module AdminAPI
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
    include AdminAPI

  end
end
