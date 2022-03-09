class CreatePeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :periods do |t|
      t.date :due, null: false
      t.integer :year, null: false
      t.integer :month, null: false
      t.integer :number, null: false
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end
  end
end
