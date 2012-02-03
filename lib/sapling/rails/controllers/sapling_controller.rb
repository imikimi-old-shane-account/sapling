class SaplingController < ApplicationController
  unloadable

  protected

  def build_feature_options
    feature_settings = sapling.feature_settings

    active_features = feature_settings.select do |feature_name,feature|
      feature_method = "#{feature_name}_active?".to_sym
      puts "testing feature_name: #{feature_name}"
      !!if responds_to?(feature_method) # note: "!!" ensures a true/false answer
      puts "testing feature_name with override: #{feature_name}"
        # override test
        send(feature_method,feature)
      else
        # normal test
      puts "testing feature_name with default: #{feature_name}"
        feature.active?(:user=>current_user)
      end
    end

    {
    :user => current_user,
    :features => feature_settings.keys,
    :active_features => active_features
    }
  end

  public

  def script
    js = sapling_js_generator.generate(build_feature_options)
    render :text => js, :content_type => 'text/javascript'
  end

end
