class CreateLeaders < ActiveRecord::Migration[5.1]
  def change
    create_table :leaders do |t|
      t.string :name
      t.string :image
      t.string :designation
      t.string :abbr
      t.boolean :featured
      t.string :description

      t.timestamps
    end
  end
end
