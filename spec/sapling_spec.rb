require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Sapling" do
  before do
    
  end
  
  describe "features default to being disabled"
  
  describe "activating a percentage"
  
  describe "deactivating a percentage"
  
  describe "activating an individual user"
  
  describe "deactivating an individual user"
    
  
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
