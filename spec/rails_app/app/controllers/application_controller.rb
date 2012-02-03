# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def current_user
    u = User.new
    u.id = session[:current_user_id]
    u
  end

  def current_user_id
    session[:current_user_id]
  end

  def my_custom_test_feature_active?(options)
    # if the user is in the sapling list, the feature is DISABLED for them
    !options[:feature].users[current_user.id]
  end
end
