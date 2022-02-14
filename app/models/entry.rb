class Entry < ApplicationRecord
  include TaxeCalculation

  belongs_to :basket
  belongs_to :basket

  before_save :calulate_tax_update_price

  private

  def calulate_tax_update_price
    self.basic_tax = calculate_basic_tax(name, quantity, price)
    self.import_tax = calculate_import_tax(name, quantity, price)
    self.final_price = calculate_final_price
  end

  def calculate_final_price
    (BigDecimal(quantity, 2) * (BigDecimal(price, 2) + BigDecimal(basic_tax, 2) + BigDecimal(import_tax, 2))).round(2)
  end
end
