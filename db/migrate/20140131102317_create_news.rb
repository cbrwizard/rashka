class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title, :null => false
      t.string :text, :null => false
      t.string :link, :null => false

      t.timestamps
    end
  end
end
