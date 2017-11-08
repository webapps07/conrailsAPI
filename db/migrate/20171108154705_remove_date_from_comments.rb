class RemoveDateFromComments < ActiveRecord::Migration[5.1]
  def up
    Comment.all.each do |comment|
      comment.update(created_at: comment.date)
    end
    
    remove_column :comments, :date, :timestamp
  end

  def down
    add_column :comments, :date, :timestamp

    Comment.all.each do |comment|
      comment.update(date: comment.created_at)
    end
  end

end
