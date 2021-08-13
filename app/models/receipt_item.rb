# frozen_string_literal: true

class ReceiptItem < ApplicationRecord
  include ReceiptManager

  belongs_to :receipt
  belongs_to :product, class_name: PRODUCT_CLASS_NAME
  validates_presence_of :quantity, :name, :price
  validates :imported, exclusion: [nil]
end
