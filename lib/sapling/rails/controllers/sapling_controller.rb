class SaplingController < ApplicationController  
  def script
    js = sapling_js_generator.generate(:user => current_user, :context_id => (request.session_options[:id] if request.session))
    render :text => js, :content_type => 'text/javascript'
  end
end
