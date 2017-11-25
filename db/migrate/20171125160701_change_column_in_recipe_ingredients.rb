class ChangeColumnInRecipeIngredients < ActiveRecord::Migration[5.0]
  def change
    rename_column :recipe_ingredients, :gift_id,:ingredient_id
  end
end
