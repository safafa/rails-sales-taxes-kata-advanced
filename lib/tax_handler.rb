# frozen_string_literal: true

module TaxHandler
  include ReceiptManager
  include Rounding

  EXEMPT_SALES_TAX_CATEGORIES = %w[book food medical].freeze
  TAX_PRECISION = 0.05
  BASIC_SALES_TAX_DECIMAL = 0.1
  IMPORT_TAX_DECIMAL = 0.05

  def calculate_sales_tax(obj)
    tax_percentage_multipler = 0
    category_name = category_name(obj.category)
    tax_percentage_multipler += BASIC_SALES_TAX_DECIMAL unless exempt_from_sales_tax?(category_name)
    tax_percentage_multipler += IMPORT_TAX_DECIMAL if obj.imported?

    return 0 if tax_percentage_multipler.zero?

    unrounded_sales_tax = obj.price * obj.quantity * tax_percentage_multipler
    rounded_sales_tax = Rounding.up_to_nearest(nearest: TAX_PRECISION, number: unrounded_sales_tax)
    rounded_sales_tax.round(2)
  end

  def exempt_from_sales_tax?(category_name)
    EXEMPT_SALES_TAX_CATEGORIES.include?(category_name)
  end
end
