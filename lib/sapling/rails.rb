require 'sapling/rails/action_controller'
require 'sapling/rails/view_helpers'

ActiveSupport::Dependencies.autoload_paths << File.expand_path(File.join(File.dirname(__FILE__), "rails", "controllers"))

if defined?(Rails)
  if Rails.version =~ /^3\./
    # Haven't tested this
    require 'sapling/rails/railtie'
  else
    ActionView::Base.send :include, Sapling::ViewHelpers
  end
end
