class CommentSerializer < ActiveModel::Serializer
  attributes :id, :rating, :comment, :author, :date

  def date
    object.created_at
  end
end
