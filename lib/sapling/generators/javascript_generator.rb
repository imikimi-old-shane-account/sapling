require "set"

class Sapling::JavascriptGenerator
  attr_accessor :sapling

  def initialize(sapling)
    @sapling=sapling
  end

  # see Sapling::API::Client for options
  def mootools_for_feature(feature, on)
    "html.removeClass('" + sapling.css_toggle_class(feature,!on) + "');html.addClass('" + sapling.css_toggle_class(feature,on) + "');"
  end

  # options
  # options is passed directly into sapling.active_features
  #   One useful option is to override the user:
  #     :user => user
  def generate(options={})
    features = sapling.features.keys
    active_features = sapling.active_features(options).keys
    inactive_features = features - active_features

    <<-END
(function() {
  if (window.MooTools) {
    html = $$('html')[0];
    #{inactive_features.map{|f| mootools_for_feature(f,false) }.join}
    #{active_features.map{|f| mootools_for_feature(f,true) }.join}
  }
})();
END
  end
end
