class CreateFeedbacks < ActiveRecord::Migration[5.1]
  def change
    create_table :feedbacks do |t|
      t.string :firstname
      t.string :lastname
      t.integer :telnum
      t.string :email
      t.string :agree
      t.string :contacttype
      t.string :message

      t.timestamps
    end
  end
end
