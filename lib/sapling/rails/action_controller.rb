require 'action_controller'

module Sapling::ActionControllerExt
  def sapling
    @sapling ||= Sapling::ActiveRecord.new(self)
  end
end

class ActionController::Base
  include Sapling::ActionControllerExt
  helper_method :sapling
end
