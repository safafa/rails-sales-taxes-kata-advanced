class CreateReceiptItems < ActiveRecord::Migration[6.1]
  def change
    create_table :receipt_items do |t|
      t.references :receipt, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, precision: 10, scale: 2, null: false
      t.string :name
      t.decimal :price
      t.string :currency
      t.boolean :imported

      t.timestamps
    end
  end
end
