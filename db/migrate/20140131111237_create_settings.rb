class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :login
      t.string :hash
      t.string :salt

      t.timestamps
    end
  end
end
