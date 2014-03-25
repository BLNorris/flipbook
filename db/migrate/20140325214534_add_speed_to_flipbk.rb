class AddSpeedToFlipbk < ActiveRecord::Migration
  def change
    add_column :flipbks, :speed, :integer
  end
end
