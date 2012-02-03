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
      options = Util.normalized_options options, controller
      active_internal(feature,options)
    end

    # returns a list of features enabled for a user
    # see Sapling::API::Client
    def active_features(options={})
      options = Util.normalized_options options, controller
      ret={}
      features.each {|feature_name,feature| ret[feature_name]=feature if active_internal(feature_name,options)}
      ret
    end

    def js_generator
      @js_generator ||= JavascriptGenerator.new
    end

    def css_class_prefix
      "sapling_feature"
    end

    # Use these classes on the container elements of your features
    def css_class(feature)
      "#{css_class_prefix}_#{feature.to_s}"
    end

    # Put these on the html element to turn on/off features
    def css_toggle_class(feature, on)
      "#{css_class(feature)}_#{on ? 'on' : 'off'}"
    end
  end
end
