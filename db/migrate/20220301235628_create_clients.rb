class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.string :contact, null: false
     
      t.timestamps
    end
  end
end
