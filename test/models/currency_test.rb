require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  test 'is valid' do
    currency = FactoryBot.build(:currency)
    assert currency.valid?
  end

  test 'mandatory fields' do
    currency = Currency.new(display_decimals: nil)
    assert !currency.valid?
    assert_equal currency.errors.map(&:attribute), %i[name symbol display_decimals]
  end
end
