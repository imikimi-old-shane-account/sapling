require 'action_controller'

module Sapling::ActionControllerExt
  def feature_active?(feature, options={})
    options[:user] ||= current_user
    sapling.active?(feature, options)
  end

  def sapling
    @sapling ||= Sapling::ActiveRecord.new(self)
  end

  def sapling_js_generator
    @sapling_js_generator ||= Sapling::JavascriptGenerator.new
  end
end

class ActionController::Base
  include Sapling::ActionControllerExt
  helper_method :feature_active?, :sapling, :sapling_js_generator
end
