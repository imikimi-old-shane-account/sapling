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

  # see Sapling::API::Client for options
  def to_s(options={})
    features = Set.new @sapling.features
    active_features = Set.new @sapling.active_features options
    inactive_features = features - active_features

    [
    active_features.collect   {|f|".#{prefix}_#{f.to_s}_off { display:hidden !important; }"},
    inactive_features.collect {|f|".#{prefix}_#{f.to_s}_on { display:hidden !important; }"},
    ].flatten.join("\n")
  end
end
end
