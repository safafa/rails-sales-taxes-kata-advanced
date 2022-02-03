class CreateBaskets < ActiveRecord::Migration[6.1]
  def change
    create_table :baskets do |t|
      t.string :sales_taxes
      t.string :total

      t.timestamps
    end
  end
end
