class Basket < ApplicationRecord
  has_many :entries, dependent: :destroy
  belongs_to :user
  scope :latest, -> { order(created_at: :desc) }

  before_save :update_taxes_and_total

  def build_entries_from_file_upload(file)
    return false unless File.extname(file) == '.txt'

    lines = file.read.split("\n")
    lines.each do |line|
      info = line.split
      quantity = info[0]
      price = info[-1]
      name = info[1..-3].join(' ')
      entry = entries.build(name: name, price: price, quantity: quantity)
      entry.save
    end
  end

  private

  def update_taxes_and_total
    self.sales_taxes = sum_tax
    self.total = sum_total
  end

  def sum_tax
    sum = 0
    entries.each do |entry|
      sum += BigDecimal(entry.basic_tax, 2) + BigDecimal(entry.import_tax, 2)
    end
    sum.round(2)
  end

  def sum_total
    sum = 0
    entries.each do |entry|
      sum += BigDecimal(entry.final_price, 2)
    end
    sum.round(2)
  end
end
