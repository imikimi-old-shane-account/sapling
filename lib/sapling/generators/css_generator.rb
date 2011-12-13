require "set"

module Sapling
class CssGenerator
  attr_accessor :sapling

  def initialize(sapling)
    @sapling=sapling
  end

  def prefix
    "sapling_css"
  end
  
  def css_class(feature, on)
    "#{prefix}_#{feature.to_s}_#{on ? 'on' : 'off'}"
  end

  # see Sapling::API::Client for options
  def to_s(options={})
    features = Set.new @sapling.features
    active_features = Set.new @sapling.active_features options
    inactive_features = features - active_features

    [
    active_features.collect   {|f|".#{css_class(f, false)} { display:none !important; }"},
    inactive_features.collect {|f|".#{css_class(f, true)} { display:none !important; }"},
    ].flatten.join("\n")
  end
end
end
