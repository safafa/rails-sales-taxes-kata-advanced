# frozen_string_literal: true

class Receipt < ApplicationRecord
  include ReceiptManager

  belongs_to :user, class_name: USER_CLASS_NAME
  has_many :receipt_items, dependent: :destroy

  def self.create_from_file(file, user)
    receipt = user.receipts.new

    Receipt.transaction do
      receipt.save
      begin
        receipt.add_items_from_file(file)
        raise ActiveRecord::Rollback if receipt.errors.any?
        raise if receipt.receipt_items.count.zero?
      rescue
        receipt.errors.add(:base, :invalid, message: 'file is an unrecognizable receipt format')
        raise ActiveRecord::Rollback
      end
    end
    receipt
  end

  def add_items_from_file(file)
    File.open(file, 'r').each_line do |line|
      item = item_from_file_line(line)
      if item.product
        item.save
      else
        errors.add(:base, :invalid, message: "file contains an unrecognizable product: '#{item.name}'")
      end
    end
  end

  def total_sales_tax
    @total_sales_tax ||= receipt_items.sum(&:sales_tax).round(2).to_f
  end

  def total
    receipt_items.sum(&:shelf_price).round(2).to_f
  end

  private

  def item_from_file_line(line)
    named_captures = line.match FILE_LINE_REGEXP
    item_from_named_captures(named_captures)
  end

  def item_from_named_captures(named_captures)
    name = named_captures[:name]
    is_imported = name.match?(/import/)
    name = remove_import_text_from_product_name(name)
    product = find_product_by_name(name)
    quantity = named_captures[:quantity]&.to_i || 1
    price = named_captures[:price]&.to_f || 0

    receipt_items.new(name: name, quantity: quantity,
                      product: product, price: price,
                      imported: is_imported)
  end

  def find_product_by_name(name)
    PRODUCT_CLASS.find_by(name: name)
  end

  def remove_import_text_from_product_name(name)
    name.gsub('imported ', '')
  end
end
