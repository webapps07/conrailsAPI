class AddDishRefToComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :dish, foreign_key: true
  end
end
