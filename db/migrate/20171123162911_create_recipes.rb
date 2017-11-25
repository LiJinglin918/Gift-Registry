class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    drop_table :recipes
    
    create_table :recipes do |t|
      t.string:name
      t.string:email
      t.timestamps
      
    end
  end
end
