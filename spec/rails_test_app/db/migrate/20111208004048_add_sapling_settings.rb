class AddSaplingSettings < ActiveRecord::Migration
  def self.up
    create_table :sapling_settings, :id => false do |t|
      t.string :feature
      t.integer :percentage
      t.integer :user_id
    end
  end

  def self.down
    drop_table :sapling_settings
  end
end