# frozen_string_literal: true

module ReceiptManager
  PRODUCT_CLASS = Product
  PRODUCT_CLASS_NAME = PRODUCT_CLASS.name
  USER_CLASS = User
  USER_CLASS_NAME = USER_CLASS.name

  def category_name(category)
    category.name
  end
end
