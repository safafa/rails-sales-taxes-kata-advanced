# frozen_string_literal: true

require 'test_helper'
require 'minitest/spec'

describe 'Rounding module' do
  let(:dummy_class) { Class.new { include Rounding } }

  describe '#round_up_to_nearest' do
    describe 'with a nearest of 0.05' do
      let(:nearest) { 0.05 }

      it 'keeps 1.60 at 1.60' do
        number = 1.60

        result = Rounding.up_to_nearest(nearest: nearest, number: number)

        assert_equal 1.60, result
      end

      it 'rounds 0.56 to 0.6' do
        number = 0.56

        result = Rounding.up_to_nearest(nearest: nearest, number: number)

        assert_equal 0.60, result
      end

      it 'rounds 1.64 to 1.65' do
        number = 1.64

        result = Rounding.up_to_nearest(nearest: nearest, number: number)

        assert_equal 1.65, result
      end
    end

    describe 'with a nearest of 0.131' do
      let(:nearest) { 0.131 }

      it 'keeps 0.131 at 0.131' do
        number = 0.131

        result = Rounding.up_to_nearest(nearest: nearest, number: number)

        assert_equal 0.131, result
      end

      it 'rounds 0.27 to 0.393' do
        number = 0.27

        result = Rounding.up_to_nearest(nearest: nearest, number: number)

        assert_equal 0.393, result
      end

      it 'rounds 1.3 to 1.31' do
        number = 1.3

        result = Rounding.up_to_nearest(nearest: nearest, number: number)

        assert_equal 1.31, result
      end
    end
  end
end
