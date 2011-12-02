require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Sapling" do
  before do
    @db = Sapling::DB::Memory.new
    @sapling = Sapling.new(@db)
  end
  
  describe "features default to being disabled" do
    it "is not active for a specific user by default" do 
      @sapling.should_not be_active(:chat, stub(:id => 5))
    end
  end
  
  describe "activating a percentage" do
    before do
      @sapling.activate_percentage(:chat, 20)
    end
    
    it "activates the fature for that percentage of users" do
      (1..120).select { |id| @sapling.active?(:chat, stub(:id => id)) }.length.should == 39
    end    
  end
  
  describe "deactivating a percentage" do
    before do
      @sapling.activate_percentage(:chat, 100)
      @sapling.deactivate_percentage(:chat)
    end
    
    it "becomes inactive for all users" do
      @sapling.should_not be_active(:chat, :stub(:id => 24))
    end
  end
  
  describe "activating a specific user" 
    
      
  describe "deactivating a specific user"
    
  
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
