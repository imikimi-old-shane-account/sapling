require 'sapling/rails/action_controller'
require 'sapling/rails/view_helpers'

if Rails.version =~ /^3\./
  require 'sapling/rails/railtie'
else
  ActionView::Base.send :include, Sapling::ViewHelpers
end