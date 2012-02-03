class SpacemanSpiffsController < ApplicationController
  # GET /spaceman_spiffs
  # GET /spaceman_spiffs.xml
  def index
    if sapling.active?(:listing)
      @spaceman_spiffs = SpacemanSpiff.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @spaceman_spiffs }
      end
    else
      render :nothing => true, :status => :forbidden
    end
  end

  def multiple_features
  end

  def custom_test_feature
    render :text => (sapling.active?(:my_custom_test_feature) ? "1" : "0")
  end
end
