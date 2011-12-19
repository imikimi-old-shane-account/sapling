module Sapling
  module ViewHelpers

    # include ActionView::Helpers::CaptureHelper
    def feature_class(feature)
      sapling_js_generator.css_container_class(feature)
    end
    
  end
end