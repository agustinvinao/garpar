class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :vat_number, null: false
      t.string :number, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
