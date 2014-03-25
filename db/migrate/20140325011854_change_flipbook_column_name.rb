class ChangeFlipbookColumnName < ActiveRecord::Migration
  def up
    rename_column :photos, :flipbook_id, :flipbk_id
  end

  def down
    rename_column :photos, :flipbk_id, :flipbook_id
  end
end
