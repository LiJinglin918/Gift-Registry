class CreateGifts < ActiveRecord::Migration[5.0]
  def change
    create_table :gifts do |t|
      t.string :name
    end
  end
end
