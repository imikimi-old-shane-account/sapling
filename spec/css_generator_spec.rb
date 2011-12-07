require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'sapling/rails'

describe "Sapling::CssGenerator" do

  before do
    ActiveRecord::Base.establish_connection(
      :adapter  => 'sqlite3',
      :database => ':memory:'
    )
    sql = File.read(File.expand_path(File.dirname(__FILE__) + '/../db/create.sql'))
    ActiveRecord::Base.connection.execute sql
    @sapling = Sapling::ActiveRecord.new
  end

  describe "creating basic css" do
    before do
      @sapling.activate_user(:chat, stub(:id => 1))
    end

    it "outputs css" do
      Sapling::CssGenerator.new(@sapling).to_s(:user => stub(:id => 1)).should == ".sapling_css_chat_off { display:hidden !important; }"
    end
  end

  describe "creating more complex css" do
    before do
      @sapling.activate_percentage(:bicycle, 10)
      @sapling.activate_user(:chat, stub(:id => 115))
      @sapling.activate_user(:pwn, stub(:id => 102))
      @sapling.activate_user(:juggle, stub(:id => 115))
    end

    it "test user bicycle & pwn user" do
      output = Sapling::CssGenerator.new(@sapling).to_s(:user => stub(:id => 102))
      %w{ bicycle_off chat_on juggle_on pwn_off }.each do |key|
        output.should =~ /#{key}[^}]+?display:hidden/
      end
    end

    it "test chat & juggle user" do
      output = Sapling::CssGenerator.new(@sapling).to_s(:user => stub(:id => 115))
      %w{ bicycle_on chat_off juggle_off pwn_on }.each do |key|
        output.should =~ /#{key}[^}]+?display:hidden/
      end
    end
  end
end
