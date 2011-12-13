module Sapling
  module ViewHelpers

    # include ActionView::Helpers::CaptureHelper
    def feature_on(feature, &block)
      feature_block(sapling_css_generator.css_class(feature, "style=\"display:none;\"", true), &block)
    end

    def feature_off(feature, &block)
      feature_block(sapling_css_generator.css_class(feature, nil, false), &block)    
    end

    private
    def feature_block(css_class, params, &block)
      concat "<span class=\"#{css_class}\" #{params}>"
      block.call 
      concat "</span>"
    end

  end
end

