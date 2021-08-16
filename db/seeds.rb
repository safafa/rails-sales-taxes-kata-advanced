# frozen_string_literal: true

books = Category.find_or_create_by(name: 'book')
food = Category.find_or_create_by(name: 'food')
medical = Category.find_or_create_by(name: 'medical')
other = Category.find_or_create_by(name: 'other')

Product.find_or_create_by(name: 'book', category_id: books.id)
Product.find_or_create_by(name: 'music CD', category_id: other.id)
Product.find_or_create_by(name: 'chocolate bar', category_id: food.id)
Product.find_or_create_by(name: 'box of chocolates', category_id: food.id)
Product.find_or_create_by(name: 'bottle of perfume', category_id: other.id)
Product.find_or_create_by(name: 'packet of headache pills', category_id: medical.id)
