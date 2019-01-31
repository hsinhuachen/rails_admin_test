class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.text :title
      t.text :title_en
      t.text :desc
      t.text :desc_en
      t.text :thumb
      t.text :url
      t.string :video
      t.text :gallery
      t.string :category
      t.string :feature
      t.integer :sorting

      t.timestamps
    end
  end
end
