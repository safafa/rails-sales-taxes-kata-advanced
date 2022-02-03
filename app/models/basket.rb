class Basket < ApplicationRecord
    has_many :entries, dependent: :destroy
end
