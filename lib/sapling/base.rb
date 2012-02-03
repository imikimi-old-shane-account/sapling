module Sapling
  class Base
    attr_accessor :controller

    def initialize(controller=nil)
      @controller = controller
    end

    def features; @features||={}; end

    private
    def active_internal(feature_name,options)
      feature_method = "#{feature_name}_active?".to_sym
      if controller && controller.respond_to?(feature_method)
        # use override
        controller.send(feature_method,options.merge(:feature => features[feature_name]))
      else
        (f=features[feature_name]) && f.active?(options)
      end
    end

    # override feature test example for feature :new_homepage
    # options:
    #   feature is of type Feature
    #   :user
    # returns true if the feature is enabled
    # def new_homepage_active?(options={})
    #  # your test here
    # end
    public

    # see Sapling::API::Client
    def active?(feature, options={})
      options = Util.normalized_options options
      active_internal(feature,options)
    end

    # returns a list of features enabled for a user
    # see Sapling::API::Client
    def active_features(options={})
      options = Util.normalized_options options
      features.select {|key,feature| active_internal(key,options)}
    end
  end
end
