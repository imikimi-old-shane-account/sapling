module Sapling
  class Railtie < Rails::Railtie
    initializer "sapling.view_helpers" do
      ActionView::Base.send :include, ViewHelpers
    end    
  end
end