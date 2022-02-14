class ChangeColumnDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:entries, :basic_tax, from: nil, to: "0")
    change_column_default(:entries, :import_tax, from: nil, to: "0")
    change_column_default(:baskets, :sales_taxes, from: nil, to: "0")
    change_column_default(:baskets, :total, from: nil, to: "0")
  end
end
