class Basket < ApplicationRecord
  has_many :entries, dependent: :destroy

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
end
