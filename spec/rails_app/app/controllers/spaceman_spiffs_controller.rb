class SpacemanSpiffsController < ApplicationController
  # GET /spaceman_spiffs
  # GET /spaceman_spiffs.xml
  def index
    if feature_active?(:listing)
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

  # GET /spaceman_spiffs/1
  # GET /spaceman_spiffs/1.xml
  def show
    @spaceman_spiff = SpacemanSpiff.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @spaceman_spiff }
    end
  end

  # GET /spaceman_spiffs/new
  # GET /spaceman_spiffs/new.xml
  def new
    @spaceman_spiff = SpacemanSpiff.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @spaceman_spiff }
    end
  end

  # GET /spaceman_spiffs/1/edit
  def edit
    @spaceman_spiff = SpacemanSpiff.find(params[:id])
  end

  # POST /spaceman_spiffs
  # POST /spaceman_spiffs.xml
  def create
    @spaceman_spiff = SpacemanSpiff.new(params[:spaceman_spiff])

    respond_to do |format|
      if @spaceman_spiff.save
        format.html { redirect_to(@spaceman_spiff, :notice => 'SpacemanSpiff was successfully created.') }
        format.xml  { render :xml => @spaceman_spiff, :status => :created, :location => @spaceman_spiff }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @spaceman_spiff.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /spaceman_spiffs/1
  # PUT /spaceman_spiffs/1.xml
  def update
    @spaceman_spiff = SpacemanSpiff.find(params[:id])

    respond_to do |format|
      if @spaceman_spiff.update_attributes(params[:spaceman_spiff])
        format.html { redirect_to(@spaceman_spiff, :notice => 'SpacemanSpiff was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @spaceman_spiff.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /spaceman_spiffs/1
  # DELETE /spaceman_spiffs/1.xml
  def destroy
    @spaceman_spiff = SpacemanSpiff.find(params[:id])
    @spaceman_spiff.destroy

    respond_to do |format|
      format.html { redirect_to(spaceman_spiffs_url) }
      format.xml  { head :ok }
    end
  end
end
