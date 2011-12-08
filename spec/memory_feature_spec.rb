require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Sapling::Memory::Feature" do
  it "should support activating users" do
    f=Sapling::Memory::Feature.new
    u=UserMock.new

    f.active?(:user=>u).should be_false
    f.activate_user(u)

    f.active?(:user=>u).should be_true
  end
end
