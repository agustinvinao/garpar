class CreateCurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :symbol
      t.integer :display_decimals, default: 2

      t.timestamps
    end
  end
end
