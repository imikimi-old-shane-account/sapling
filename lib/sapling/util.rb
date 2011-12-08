module Sapling
  class Util
    class << self
      def context_id(options)
        options[:context_id] || options[:user].id
      end

      def normalized_options(options)
        options[:user_id] ||= options[:user].id if options[:user]
        options[:context_id] ||= options[:user_id] || (raise ArgumentError.new("context_id, user_id or user required, #{options.inspect}"))
        options
      end
    end
  end
end
