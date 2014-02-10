class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.string :text, :null => false
      t.integer :popularity, :default => 1

      t.timestamps
    end
  end
end
