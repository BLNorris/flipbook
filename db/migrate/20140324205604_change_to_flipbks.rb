class ChangeToFlipbks < ActiveRecord::Migration
  def up
    rename_table :flipbooks, :flipbks
  end

  def down
    rename_table :flipbks, :flipbooks
  end
end
