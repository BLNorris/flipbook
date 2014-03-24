class ChangePicturesToPhotos < ActiveRecord::Migration
  def up
    rename_table :pictures, :photos
  end

  def down
    rename_table :photos, :pictures
  end
end
