class AddIndexToPlaces < ActiveRecord::Migration
  def change
    add_index :places, :type_id
  end
end
