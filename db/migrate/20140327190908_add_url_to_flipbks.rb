class AddUrlToFlipbks < ActiveRecord::Migration
  def change
    add_column :flipbks, :url, :string
  end
end
