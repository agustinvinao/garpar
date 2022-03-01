require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test 'has companies' do
    assert FactoryBot.create(:address).companies.size, 0
  end
end
