class RenameSharesGp < ActiveRecord::Migration
  def change
    rename_column :stats, :shares_gp, :shares_bl
  end
end
