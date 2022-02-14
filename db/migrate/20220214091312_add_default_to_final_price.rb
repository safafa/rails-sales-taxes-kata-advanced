class AddDefaultToFinalPrice < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:entries, :final_price, from: nil, to: "0")
  end
end
