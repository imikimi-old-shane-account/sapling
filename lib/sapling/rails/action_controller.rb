module Sapling::ActionControllerExt
  def feature_active?(feature, options={})
    options[:user] ||= current_user
    sapling.active?(feature, options)
  end
  
  def sapling
    @@sapling ||= Sapling::ActiveRecord.new
  end
end

class ActionController::Base
  include Sapling::ActionControllerExt
  helper_method :feature_active?
end