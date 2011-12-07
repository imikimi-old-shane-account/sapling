require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'active_record'

describe "Sapling::ActiveRecord" do
  it_behaves_like Sapling do
    before do
      ActiveRecord::Base.establish_connection(
        :adapter  => 'sqlite3',
        :database => ':memory:'
      )
      sql = File.read(File.expand_path(File.dirname(__FILE__) + '/../db/create.sql'))
      ActiveRecord::Base.connection.execute sql
      @sapling = Sapling::ActiveRecord.new
    end
  end
end
