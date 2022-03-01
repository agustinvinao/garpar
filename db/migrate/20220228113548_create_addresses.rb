class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :line1, null: false
      t.string :line2
      t.string :line3
      t.string :postal_code, null: false
      t.string :county, null: false
      t.string :country, null: false

      t.timestamps
    end
  end
end
