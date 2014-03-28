class AddOrderToBooks < ActiveRecord::Migration
  def change
    add_column :flipbks, :order, :integer
  end
end
