# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :receipts, dependent: :destroy

  def create_receipt_from_file(file)
    Receipt.create_from_file(file, self)
  end
end
