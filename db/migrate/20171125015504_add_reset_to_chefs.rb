class AddResetToChefs < ActiveRecord::Migration[5.0]
  def change
    add_column :chefs, :reset_digest, :string
    add_column :chefs, :reset_sent_at, :datetime
  end
end
