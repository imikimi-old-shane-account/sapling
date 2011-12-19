require "set"

class Sapling::JavascriptGenerator
  attr_accessor :sapling

  def initialize(sapling)
    @sapling=sapling
  end

  def prefix
    "sapling_feature"
  end
    
  # Use these classes on the container elements of your features
  def css_container_class(feature)
    "#{prefix}_#{feature.to_s}"
  end

  # Put these on the html element to turn on/off features
  def css_toggle_class(feature, on)
    "#{css_container_class(feature)}_#{on ? 'on' : 'off'}"
  end


  # see Sapling::API::Client for options
  
  def js_for_feature(feature, on)
    "html.removeClass('" + css_toggle_class(feature,!on) + "');html.addClass('" + css_toggle_class(feature,on) + "');"
  end
  
  def generate(options={})
    features = Set.new @sapling.features
    active_features = Set.new @sapling.active_features options
    inactive_features = features - active_features

    
    <<-END
(function() {
  if (window.MooTools) {
    html = $$('html')[0];
    #{inactive_features.map{|f| js_for_feature(f,false) }.join}
    #{active_features.map{|f| js_for_feature(f,true) }.join}    
  }
})();
END
  end
end
