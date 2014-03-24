class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.integer :flipbook_id
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
