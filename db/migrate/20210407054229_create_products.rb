class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :reference, index: true
      t.string :category
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
