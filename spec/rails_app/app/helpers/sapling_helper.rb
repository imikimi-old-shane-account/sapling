# require 'action_pack'
module SaplingHelper
  # include ActionView::Helpers::CaptureHelper
  def feature_on(feature, &block)
    feature_block(sapling_css_generator.css_class(feature, true), "style='display:none;'", &block)
  end

  def feature_off(feature, &block)
    feature_block(sapling_css_generator.css_class(feature, false), nil, &block)
  end


  private
  def feature_block(css_class, params, &block)
    concat "<span class=\"#{css_class}\" #{params}>"
    block.call
    concat "</span>"
  end


end

# ActionView::Base.new.extend SaplingHelper
