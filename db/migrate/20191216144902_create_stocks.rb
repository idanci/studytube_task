class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.references :bearer
      t.string :name, null: false
      t.boolean :deleted, null: false, default: false

      t.timestamps
    end
    add_index :stocks, :name, unique: true
  end
end
