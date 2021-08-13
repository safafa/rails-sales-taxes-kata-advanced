# frozen_string_literal: true

class Category < ApplicationRecord
  include ReceiptManager

  has_many :products, class_name: PRODUCT_CLASS_NAME

  validates :name, presence: true
end
