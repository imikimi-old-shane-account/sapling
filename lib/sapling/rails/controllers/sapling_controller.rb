class SaplingController < ApplicationController
  unloadable

  def script
    js = sapling.js_generator.generate(
      :features => sapling.features.keys,
      :active_features => sapling.active_features
    )
    render :text => js, :content_type => 'text/javascript'
  end
end
