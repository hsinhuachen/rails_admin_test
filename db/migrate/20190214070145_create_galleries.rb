class CreateGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table :galleries do |t|
      t.string :name
      t.integer :sorting
      t.integer :project_id

      t.timestamps
    end
  end
end
