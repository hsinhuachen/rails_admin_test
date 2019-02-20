class AddStatusToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :status, :integer
    remove_column :projects, :gallery
  end
end
