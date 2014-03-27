class AddDisplayToFlipbks < ActiveRecord::Migration
  def change
    add_attachment :flipbks, :display
  end
end
