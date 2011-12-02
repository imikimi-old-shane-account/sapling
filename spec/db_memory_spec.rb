require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Sapling::Memory" do

  it "should init" do
    Sapling::Memory.new
  end

  it "should support activating users" do
    mem = Sapling::Memory.new
    user = UserMock.new

    mem.active?(:my_feature, user).should be_false

    mem.activate_user(:my_feature, user)
    mem.active?(:my_feature, user).should be_true
  end

  it "should support deactivating users" do
    mem = Sapling::Memory.new
    user = UserMock.new

    mem.activate_user(:my_feature, user)
    mem.active?(:my_feature, user).should be_true

    mem.deactivate_user(:my_feature, user)
    mem.active?(:my_feature, user).should be_false
  end
end
