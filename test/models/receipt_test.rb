# frozen_string_literal: true

require 'test_helper'

class ReceiptTest < ActiveSupport::TestCase
  def user
    users(:one)
  end

  test 'self.create_from_file creates a Receipt and ReceiptItems and returns the receipt from valid import file' do
    returned_value = nil

    assert_difference -> { Receipt.count } => 1, -> { ReceiptItem.count } => 3 do
      returned_value = Receipt.create_from_file(valid_receipt_one, user)
    end

    assert_instance_of Receipt, returned_value
    assert_equal 3, returned_value.receipt_items.count
  end

  test 'self.create_from_file creates ReceiptItems with correct attributes' do
    assert_difference 'ReceiptItem.count', 4 do
      Receipt.create_from_file(valid_receipt_three, user)
    end

    receipt_item_one = ReceiptItem.first
    assert_equal 'bottle of perfume', receipt_item_one.name
    assert_equal 1, receipt_item_one.quantity
    assert_equal 27.99, receipt_item_one.price
    assert_equal true, receipt_item_one.imported
    assert_equal receipt_item_one.name, receipt_item_one.product.name

    receipt_item_two = ReceiptItem.find(2)
    assert_equal 'bottle of perfume', receipt_item_two.name
    assert_equal 1, receipt_item_two.quantity
    assert_equal 18.99, receipt_item_two.price
    assert_equal false, receipt_item_two.imported
    assert_equal receipt_item_two.name, receipt_item_two.product.name

    receipt_item_three = ReceiptItem.find(3)
    assert_equal 'packet of headache pills', receipt_item_three.name
    assert_equal 1, receipt_item_three.quantity
    assert_equal 9.75, receipt_item_three.price
    assert_equal false, receipt_item_three.imported
    assert_equal receipt_item_three.name, receipt_item_three.product.name

    receipt_item_four = ReceiptItem.last
    assert_equal 'box of chocolates', receipt_item_four.name
    assert_equal 1, receipt_item_four.quantity
    assert_equal 11.25, receipt_item_four.price
    assert_equal true, receipt_item_four.imported
    assert_equal receipt_item_four.name, receipt_item_four.product.name
  end

  test 'self.create_from_file does not create a Receipt if the file is blank' do
    returned_value = nil

    assert_no_difference ['ReceiptItem.count', 'Receipt.count'] do
      returned_value = Receipt.create_from_file(blank_file, user)
    end

    assert_instance_of Receipt, returned_value
    assert_equal returned_value.errors.full_messages.first, 'file is an unrecognizable receipt format'
  end

  test 'self.create_from_file does not create a Receipt or any ReceiptItems if one line is an invalid format' do
    returned_value = nil

    assert_no_difference ['ReceiptItem.count', 'Receipt.count'] do
      returned_value = Receipt.create_from_file(invalid_receipt_format, user)
    end

    assert_instance_of Receipt, returned_value
    assert_equal returned_value.errors.full_messages.first, 'file is an unrecognizable receipt format'
  end

  test 'self.create_from_file does not create a Receipt or any ReceiptItems if receipt product is not found' do
    returned_value = nil

    assert_no_difference ['ReceiptItem.count', 'Receipt.count'] do
      returned_value = Receipt.create_from_file(invalid_receipt_product, user)
    end

    assert_instance_of Receipt, returned_value
    assert_equal(returned_value.errors.full_messages.first, "file contains an unrecognizable product: 'non-existent'")
  end

  test 'returns correct total and sales tax total with acceptance data 1' do
    receipt = Receipt.create_from_file(valid_receipt_one, user)

    assert_equal 1.50, receipt.total_sales_tax
    assert_equal 29.83, receipt.total
  end

  test 'returns correct total and sales tax total with acceptance data 2' do
    receipt = Receipt.create_from_file(valid_receipt_two, user)

    assert_equal 7.65, receipt.total_sales_tax
    assert_equal 65.15, receipt.total
  end

  test 'returns correct total and sales tax total with acceptance data 3' do
    receipt = Receipt.create_from_file(valid_receipt_three, user)

    assert_equal 6.70, receipt.total_sales_tax
    assert_equal 74.68, receipt.total
  end
end
