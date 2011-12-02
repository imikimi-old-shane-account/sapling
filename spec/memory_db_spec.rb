require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SaplingDBMemory" do

  it "should init" do
    Sapling::DB::Memory.new
  end
end
