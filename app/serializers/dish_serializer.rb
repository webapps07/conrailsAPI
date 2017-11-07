class DishSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :category, :label, :price, :featured, :description, :created_at

  has_many :comments
end
