class CreateCriteriaDefinitions < ActiveRecord::Migration[6.1]
  def change
    create_table :criteria_definitions do |t|
      t.text :references, array: true, default: []
      t.text :categories, array: true, default: []
      t.decimal :max_product_price, precision: 8, scale: 2
      t.string :destination

      t.timestamps
    end

    add_index :criteria_definitions, [:references, :categories, :max_product_price], unique: true, name: 'criteria_definitions_ref_cat_max_price'
  end
end
