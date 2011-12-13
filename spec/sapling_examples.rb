require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

shared_examples_for Sapling do

  describe "features default to being disabled" do
    it "is not active for a specific user by default" do
      @sapling.should_not be_active(:chat, :user => stub(:id => 5))
    end
  end
  
  describe "nothing activated" do

    it "should not be active without a context or user" do
      @sapling.should_not be_active(:chat)
    end
  end
  

  describe "activating a percentage" do
    before do
      @sapling.activate_percentage(:chat, 20)
    end

    it "activates the feature for that percentage of users" do
      (1..1000).select { |id| @sapling.active?(:chat, :user=>UserMock.new(id)) }.length.should == 200
    end
    
    it "should not be active without a context or user" do
      @sapling.should_not be_active(:chat)
    end
    
  end
  
  describe "activating a 20 percent" do
    before do
      @sapling.activate_percentage(:chat, 20)
    end

    it "activates the feature for that percentage of users" do
      (1..1000).select { |id| @sapling.active?(:chat, :user=>UserMock.new(id)) }.length.should == 200
    end
    
    it "should not be active even without a context or user" do
      @sapling.should be_active(:chat)
    end
    
  end

  describe "activating a 100 percent" do
    before do
      @sapling.activate_percentage(:chat, 100)
    end

    it "activates the feature for that percentage of users" do
      (1..1000).select { |id| @sapling.active?(:chat, :user=>UserMock.new(id)) }.length.should == 1000
    end
    
    it "should be active even without a context or user" do
      @sapling.should be_active(:chat)
    end
    
  end


  describe "deactivating a percentage" do
    before do
      @sapling.activate_percentage(:chat, 100)
      @sapling.deactivate_percentage(:chat)
    end

    it "becomes inactive for all users" do
      @sapling.should_not be_active(:chat, :user => stub(:id => 24))
    end

    it "should not be active without a context or user" do
      @sapling.should_not be_active(:chat)
    end
        
  end

  describe "activating a specific user" do
    before do
      @sapling.activate_user(:chat, stub(:id => 2))
    end

    it "activates the feature for that user" do
      @sapling.should be_active(:chat, :user => stub(:id => 2))
    end
    
    it "should not be active without a context or user" do
      @sapling.should_not be_active(:chat)
    end    
  end

  describe "deactivating a specific user" do
    before do
      @sapling.activate_user(:chat, stub(:id => 2))
      @sapling.deactivate_user(:chat, stub(:id => 2))
    end

    it "deactivates the feature for that user" do
      @sapling.should_not be_active(:chat, :user => stub(:id => 2))
    end
  end

  describe "activate percentage consider a generic integer" do
    before do
      @sapling.activate_percentage(:chat, 20)
    end

    it "activates a context_id" do
      @sapling.should_not be_active(:chat, :context_id => 60)
    end
  end

  describe "fetching all features" do
    before do
      @sapling.activate_user(:chat, stub(:id => 2))
      @sapling.activate_user(:chat, stub(:id => 3))
      @sapling.activate_user(:pwn, stub(:id => 2))
    end

    it "returns only two features" do
      @sapling.features.should == [:chat, :pwn]
    end
  end

  describe "fetching all active features for a user" do
    before do
      @sapling.activate_percentage(:bicycle, 10)
      @sapling.activate_user(:chat,   stub(:id => 115))
      @sapling.activate_user(:pwn,    stub(:id => 102))
      @sapling.activate_user(:juggle, stub(:id => 115))
    end

    it "should return only the active features for the specific user" do
      @sapling.active_features(:user => stub(:id => 102)).should == [:bicycle, :pwn]
      @sapling.active_features(:user => stub(:id => 115)).should == [:chat, :juggle]
    end
  end


end
#
#
# feature :string
# user_id :integer
# group :string
# percentage :integer
#
#
# select count(*) from saplingawfwefwef where feature = 'aabce'
# and percentage < #{user_id % 100}
#
# select count(*) from saplingawfwefwef where feature = 'aabce'
# and group = 'admins'
#
# select count(*) from saplingawfwefwef where feature = 'aabce'
# and user_id = 123
#
# select feature from sapling where user_id = id or precentage < userid% 100 or group in (#{groups.join(',')})
#
# def current_features
#   @features ||=
# end
#
