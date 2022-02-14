class Entry < ApplicationRecord
  EXEMPT_FROM_TAX = %w[chocolate book pills].freeze
  IMPORTED_GOOD = 'imported'.freeze
  BASIC_TAX_RATE = 0.1
  IMPORT_TAX_RATE = 0.05
  PRESITION = 20.0

  belongs_to :basket
  belongs_to :basket

  before_save :calulate_tax_update_price

  private

  def calulate_tax_update_price
    self.basic_tax = calculate_basic_tax
    self.import_tax = calculate_import_tax
    self.final_price = calculate_final_price
  end

  def calculate_basic_tax
    unless EXEMPT_FROM_TAX.any? do |exception|
             name.include?(exception)
           end
      return round_up(BigDecimal(quantity,
                                 2) * BigDecimal(price,
                                                 2) * BigDecimal(BASIC_TAX_RATE,
                                                                 2))
    end

    0
  end

  def calculate_import_tax
    if name.include?(IMPORTED_GOOD)
      return round_up(BigDecimal(quantity,
                                 2) * BigDecimal(price,
                                                 2) * BigDecimal(IMPORT_TAX_RATE, 2))
    end

    0
  end

  def calculate_final_price
    (BigDecimal(quantity, 2) * (BigDecimal(price, 2) + BigDecimal(basic_tax, 2) + BigDecimal(import_tax, 2))).round(2)
  end

  def round_up(value)
    (value * PRESITION).ceil / PRESITION
  end
end
