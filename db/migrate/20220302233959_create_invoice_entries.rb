class CreateInvoiceEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_entries do |t|
      t.string :description, null: false
      t.float :amount, null: false, default: 0
      t.float :rate, null: false, default: 0
      t.float :vat, null: false, default: 0
      t.references :currency, null: false, foreign_key: true
      t.references :period, null: false, foreign_key: true

      t.timestamps
    end
  end
end
