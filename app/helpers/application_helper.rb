# frozen_string_literal: true

module ApplicationHelper
  def money_as_string(money)
    format('%.2f', money)
  end
end
