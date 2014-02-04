class RenameCoords < ActiveRecord::Migration
  def change
    rename_column :places, :x_coords, :lat
    rename_column :places, :y_coords, :lng
  end
end
