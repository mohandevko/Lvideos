class AddSocialColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users,:f_connected,:boolean,:default => false
    add_column :users,:t_connected,:boolean,:default => false
    add_column :users,:l_connected,:boolean,:default => false
  end
end
