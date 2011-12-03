module Sapling
  class Util
    class << self
      def context_id(options)
        options[:context_id] || options[:user].id
      end

      def normalized_options(options)
        case options
        when Hash then options
        when Integer then {:context_id => options}
        else {:user => options}
        end
      end
    end
  end
end