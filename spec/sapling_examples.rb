require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

shared_examples_for Sapling do

  describe "features default to being disabled" do
    it "is not active for a specific user by default" do
      @sapling.should_not be_active(:chat, stub(:id => 5))
    end
  end

  describe "activating a percentage" do
    before do
      @sapling.activate_percentage(:chat, 20)
    end

    it "activates the feature for that percentage of users" do
      (1..1000).select { |id| @sapling.active?(:chat, UserMock.new(id)) }.length.should == 200
    end
  end

  describe "deactivating a percentage" do
    before do
      @sapling.activate_percentage(:chat, 100)
      @sapling.deactivate_percentage(:chat)
    end

    it "becomes inactive for all users" do
      @sapling.should_not be_active(:chat, stub(:id => 24))
    end
  end

  describe "activating a specific user" do
    before do
      @sapling.activate_user(:chat, stub(:id => 2))
    end

    it "activates the feature for that user" do
      @sapling.should be_active(:chat, stub(:id => 2))
    end
  end

  describe "deactivating a specific user" do
    before do
      @sapling.activate_user(:chat, stub(:id => 2))
      @sapling.deactivate_user(:chat, stub(:id => 2))
    end

    it "deactivates the feature for that user" do
      @sapling.should_not be_active(:chat, stub(:id => 2))
    end
  end

  describe "activate percentage consider a generic integer" do
    before do
      @sapling.activate_percentage(:chat, 20)
    end

    it "activates a context_id" do
      @sapling.should_not be_active(:chat, 60)
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
