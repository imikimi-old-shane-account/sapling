class SaplingController < ApplicationController
  def stylesheet
    styles = sapling_css_generator.to_s(:user => current_user, :context_id => (request.session_options[:id] if request.session))
    # styles = "boo"
    render :text => styles, :content_type => 'text/css'
  end
end
