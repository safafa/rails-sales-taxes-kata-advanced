module TaxeCalculation
  EXEMPT_FROM_TAX = %w[chocolate book pills].freeze
  IMPORTED_GOOD = 'imported'.freeze
  BASIC_TAX_RATE = 0.1
  IMPORT_TAX_RATE = 0.05
  PRESITION = 20.0

  def calculate_basic_tax(name, quantity, price)
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

  def calculate_import_tax(name, quantity, price)
    if name.include?(IMPORTED_GOOD)
      return round_up(BigDecimal(quantity,
                                 2) * BigDecimal(price,
                                                 2) * BigDecimal(IMPORT_TAX_RATE, 2))
    end

    0
  end

  def round_up(value)
    (value * PRESITION).ceil / PRESITION
  end
end
