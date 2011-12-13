require 'action_controller'

module Sapling::ActionControllerExt
  def feature_active?(feature, options={})
    options[:user] ||= current_user
    sapling.active?(feature, options)
  end
  
  
  def sapling
    @@sapling ||= Sapling::ActiveRecord.new
  end
  
  def sapling_css_generator
    @@sapling_css_generator ||= Sapling::CssGenerator.new(sapling)
  end
  
end

class ActionController::Base
  include Sapling::ActionControllerExt
  helper_method :feature_active?, :sapling, :sapling_css_generator
end