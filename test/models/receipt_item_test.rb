# frozen_string_literal: true

require 'test_helper'

class ReceiptItemTest < ActiveSupport::TestCase
  test 'returns correct shelf price and sales tax for items with no sales tax' do
    item = ReceiptItem.new(quantity: 1, price: 12.49, imported: false, product: products(:book))

    shelf_price = item.shelf_price
    sales_tax = item.sales_tax
    assert_equal shelf_price, 12.49
    assert_equal sales_tax, 0
  end

  test 'returns correct shelf price and sales tax for items with only basic sales tax' do
    item = ReceiptItem.new(quantity: 1, price: 14.99, imported: false, product: products(:music_cd))

    shelf_price = item.shelf_price
    sales_tax = item.sales_tax
    assert_equal shelf_price, 16.49
    assert_equal sales_tax, 1.50
  end

  test 'returns correct shelf price and sales tax for items with only import tax' do
    item = ReceiptItem.new(quantity: 1, price: 10.00, imported: true, product: products(:chocolate))

    shelf_price = item.shelf_price
    sales_tax = item.sales_tax
    assert_equal shelf_price, 10.50
    assert_equal sales_tax, 0.50
  end

  test 'returns correct shelf price and sales tax for items with basic sales tax and import tax' do
    item = ReceiptItem.new(quantity: 1, price: 47.50, imported: true, product: products(:music_cd))

    shelf_price = item.shelf_price
    sales_tax = item.sales_tax
    assert_equal shelf_price, 54.65
    assert_equal sales_tax, 7.15
  end

  test 'returns receipt like friendly text through #to_s' do
    unimported_item = ReceiptItem.new(quantity: 1, price: 12.49, imported: false, name: 'book',
                                      product: products(:book))
    assert_equal '1 book: 12.49', unimported_item.to_s

    imported_item = ReceiptItem.new(quantity: 1, price: 10.00, imported: true,
                                    name: 'box of chocolates', product: products(:chocolate_box))
    assert_equal '1 imported box of chocolates: 10.50', imported_item.to_s
  end
end
