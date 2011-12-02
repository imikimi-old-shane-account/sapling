require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Sapling::DB::Memory::Feature" do
  it "should support creation with users" do
    u=UserMock.new
    f=Sapling::DB::Memory::Feature.new([u])
    f.active?(u).should be_true
  end

  it "should support activating users" do
    f=Sapling::DB::Memory::Feature.new
    u=UserMock.new

    f.active?(u).should be_false
    f.activate_user(u)

    f.active?(u).should be_true
  end
end
