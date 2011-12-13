module Sapling
  class Util
    CONTEXT_ID_ONLY_ENABLED_IF_100_PERCENT_ENABLED = 99

    class << self
      def context_id(options)
        options[:context_id] || ((u=options[:user]) && u.id)
      end
      def modded_context_id(options)
        ((cid=context_id(options)) && (cid%100)) || CONTEXT_ID_ONLY_ENABLED_IF_100_PERCENT_ENABLED
      end

      def normalized_options(options)
        options[:user_id] ||= options[:user].id if options[:user]
        options[:context_id] ||= options[:user_id]
        options
      end
    end
  end
end
