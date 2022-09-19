class CreateDishIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :dish_ingredients do |t|
      t.references :dish, null: false, foreign_key: true
      t.references :ingredient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
