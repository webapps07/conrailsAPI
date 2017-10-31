class CreateDishes < ActiveRecord::Migration[5.1]
  def change
    create_table :dishes do |t|
      t.string :name
      t.string :image
      t.string :category
      t.string :label
      t.string :price
      t.boolean :featured
      t.string :description

      t.timestamps
    end
  end
end
