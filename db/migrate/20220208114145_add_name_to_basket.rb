class AddNameToBasket < ActiveRecord::Migration[6.1]
  def change
    add_column :baskets, :name, :string
  end
end
