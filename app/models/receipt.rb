# frozen_string_literal: true

class Receipt < ApplicationRecord
  include ReceiptManager

  belongs_to :user, class_name: USER_CLASS_NAME
end
