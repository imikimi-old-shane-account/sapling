class SaplingController < ApplicationController
  unloadable
  def script
    js = sapling_js_generator.generate(:user => current_user)
    render :text => js, :content_type => 'text/javascript'
  end
end
