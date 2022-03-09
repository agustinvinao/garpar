require 'test_helper'

class PeriodsHelperTest < ActionView::TestCase
  test '#total_period_vat' do
    address = FactoryBot.create(:client_address)
    period  = FactoryBot.create(:period, client: address.addressable, invoice_entries: build_list(:invoice_entry, 2))
    vat     = period.invoice_entries.reduce(0) do |sum, invoice_entry|
      sum + ((invoice_entry.rate * invoice_entry.amount) * (invoice_entry.vat.to_f / 100))
    end
    assert_equal total_period_vat(period), vat
  end

  test '#total_period_net' do
    address = FactoryBot.create(:client_address)
    period  = FactoryBot.create(:period, client: address.addressable, invoice_entries: build_list(:invoice_entry, 2))
    net     = period.invoice_entries.reduce(0) do |sum, invoice_entry|
      sum + (invoice_entry.rate * invoice_entry.amount)
    end
    assert_equal total_period_net(period), net
  end

  test '#total_period_gross' do
    address = FactoryBot.create(:client_address)
    period  = FactoryBot.create(:period, client: address.addressable, invoice_entries: build_list(:invoice_entry, 2))
    gross   = total_period_net(period) + total_period_vat(period)
    assert_equal total_period_gross(period), gross
  end

  test '#total_period_invoice' do
    address = FactoryBot.create(:client_address)
    period  = FactoryBot.create(:period, client: address.addressable, invoice_entries: build_list(:invoice_entry, 2))
    total   = total_period_invoice(period)
    assert_equal total_period_invoice(period), total
  end

  test '#total_period_expenses' do
    address = FactoryBot.create(:client_address)
    period  = FactoryBot.create(:period, client: address.addressable, expense_entries: build_list(:expense_entry, 2))
    total   = period.expense_entries.reduce(0) do |sum, expense_entry|
      sum + (expense_entry.amount * (expense_entry.claim_percentage.to_f / 100))
    end
    assert_equal total_period_expenses(period), total
  end

  test '#amount_with_currency' do
    address = FactoryBot.create(:client_address)
    period  = FactoryBot.create(:period, client: address.addressable, invoice_entries: build_list(:invoice_entry, 2))
    total_with_currency = number_to_currency(
      1,
      precision: period.invoice_entries.first.currency.display_decimals,
      unit: period.invoice_entries.first.currency.symbol
    )
    assert_equal amount_with_currency(period, 1), total_with_currency
  end

  test '#amount_with_currency bad data' do
    assert_nil amount_with_currency(nil, 1)
  end
end
