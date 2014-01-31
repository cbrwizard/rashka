class CreateRenameSettingsFields < ActiveRecord::Migration
  def change
    rename_column :settings, :hash, :password_hash
    rename_column :settings, :salt, :password_salt
  end
end
