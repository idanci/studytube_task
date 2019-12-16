class CreateBearers < ActiveRecord::Migration[6.0]
  def change
    create_table :bearers do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :bearers, :name, unique: true
  end
end
