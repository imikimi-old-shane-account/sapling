require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Sapling::JavascriptGenerator" do

  before do
    ActiveRecord::Base.establish_connection(
      :adapter  => 'sqlite3',
      :database => ':memory:'
    )
    sql = File.read(File.expand_path(File.dirname(__FILE__) + '/../db/create.sql'))
    ActiveRecord::Base.connection.execute sql
    @sapling = Sapling::ActiveRecord.new
  end

  describe "creating basic js" do
    before do
      @sapling.activate_user(:chat, stub(:id => 1))
    end

    it "outputs js with user set via controller's current_user method" do
      @sapling.controller = stub(:current_user => stub(:id => 1))
      output = Sapling::JavascriptGenerator.new(@sapling).generate
      output.should include 'html.addClass(\'sapling_feature_chat_on\');'
    end

    it "outputs js with user set by passing in the user as an option" do
      output = Sapling::JavascriptGenerator.new(@sapling).generate(:user => stub(:id => 1))
      output.should include 'html.addClass(\'sapling_feature_chat_on\');'
    end
  end

  describe "creating more complex js" do
    before do
      @sapling.activate_percentage(:bicycle, 10)
      @sapling.activate_user(:chat, stub(:id => 115))
      @sapling.activate_user(:pwn, stub(:id => 102))
      @sapling.activate_user(:juggle, stub(:id => 115))
    end

    it "test user bicycle & pwn user" do
      output = Sapling::JavascriptGenerator.new(@sapling).generate(:user => stub(:id => 102))
      expected_features = {
        'bicycle' => true,
        'chat'    => false,
        'juggle'  => false,
        'pwn'     => true
      }
      expected_features.each_pair do |key, enabled|
        output.should include "html.addClass('sapling_feature_#{key}_#{enabled ? 'on' : 'off'}');"
        output.should include "html.removeClass('sapling_feature_#{key}_#{!enabled ? 'on' : 'off'}');"
      end
    end

    it "test chat & juggle user" do
      output = Sapling::JavascriptGenerator.new(@sapling).generate(:user => stub(:id => 115))
      expected_features = {
        'bicycle' => false,
        'chat'    => true,
        'juggle'  => true,
        'pwn'     => false
      }
      expected_features.each_pair do |key, enabled|
        output.should include "html.addClass('sapling_feature_#{key}_#{enabled ? 'on' : 'off'}');"
        output.should include "html.removeClass('sapling_feature_#{key}_#{!enabled ? 'on' : 'off'}');"
      end
    end
  end
end
