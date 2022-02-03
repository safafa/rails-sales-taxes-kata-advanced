class Basket < ApplicationRecord
  has_many :entries, dependent: :destroy

  before_save :update_taxes_update_total

  def build_entries_from_file_upload(file)
    lines = file.read.split("\n")
    lines.each do |line|
      info = line.split
      quantity = info[0]
      price = info[-1]
      name = info[1..-3].join(' ')
      entry = entries.build(name: name, price: price, quantity: quantity, basic_tax: 0, import_tax: 0)
      entry.save
    end
  end

  private

  def update_taxes_update_total
    self.sales_taxes = sum_tax
    self.total = sum_total
  end

  def sum_tax
    sum = 0
    entries.each do |entry|
      sum += entry.basic_tax.to_f + entry.import_tax.to_f
    end
    sum.round(2)
  end

  def sum_total
    sum = 0
    entries.each do |entry|
      sum += entry.final_price.to_f
    end
    sum.round(2)
  end
end
