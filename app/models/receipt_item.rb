# frozen_string_literal: true

class ReceiptItem < ApplicationRecord
  include ReceiptManager
  include TaxHandler

  belongs_to :receipt
  belongs_to :product, class_name: PRODUCT_CLASS_NAME

  validates_presence_of :quantity, :name, :price
  validates :imported, exclusion: [nil]

  def category
    product.category
  end

  def sales_tax
    @sales_tax ||= calculate_sales_tax(self)
  end

  def shelf_price
    @shelf_price ||= (price * quantity + sales_tax).round(2)
  end
end
