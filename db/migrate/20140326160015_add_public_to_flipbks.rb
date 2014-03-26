class AddPublicToFlipbks < ActiveRecord::Migration
  def change
    add_column :flipbks, :public, :boolean
  end
end
