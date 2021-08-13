# frozen_string_literal: true

require 'bigdecimal/util'

module Rounding
  def self.up_to_nearest(nearest:, number:)
    number = number.to_d
    nearest = nearest.to_d
    remainder = number % nearest
    return number if remainder.zero?

    number + nearest - remainder
  end
end
