class CreateBankAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_accounts do |t|
      t.string :name, null: false
      t.string :sort_code, null: false
      t.string :account_number, null: false
      t.string :iban, null: false
      t.string :bic, null: false
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
