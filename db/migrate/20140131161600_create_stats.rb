class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :people_left, :default => 0
      t.integer :shares_vk, :default => 0
      t.integer :shares_tw, :default => 0
      t.integer :shares_fb, :default => 0
      t.integer :shares_gp, :default => 0

      t.timestamps
    end
  end
end
