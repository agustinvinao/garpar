module PeriodsHelper
  def total_period_vat(period)
    period.invoice_entries.reduce(0) do |sum, invoice_entry|
      sum + ((invoice_entry.rate * invoice_entry.amount) * (invoice_entry.vat.to_f / 100))
    end
  end

  def total_period_net(period)
    period.invoice_entries.reduce(0) do |sum, invoice_entry|
      sum + (invoice_entry.rate * invoice_entry.amount)
    end
  end

  def total_period_gross(period)
    total_period_net(period) + total_period_vat(period)
  end

  def total_period_invoice(period)
    total_period_gross(period)
  end

  def total_period_expenses(period)
    period.expense_entries.reduce(0) do |sum, expense_entry|
      sum + (expense_entry.amount * (expense_entry.claim_percentage.to_f / 100))
    end
  end

  def amount_with_currency(period, amount)
    return unless period&.invoice_entries && period.invoice_entries.size.positive?

    currency = period_currency(period)
    number_to_currency(
      amount,
      precision: currency.display_decimals,
      unit: currency.symbol
    )
  end

  def period_currency(period)
    period.invoice_entries.first.currency if period&.invoice_entries && period.invoice_entries.size.positive?
  end
end
