require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Sapling::Memory" do
  it_behaves_like Sapling do
    before do
      @sapling = Sapling::Memory.new
    end
  end
end
