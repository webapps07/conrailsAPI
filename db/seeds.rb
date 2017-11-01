# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dishes_json = ActiveSupport::JSON.decode(File.read('db/seeds/dishes.json'))
dishes_json.each do |dj|
    dish = dj.except("comments")
    d = Dish.create!(dish)
    comments = dj["comments"]
    # comments.each { |c| d.comments << Comment.create!(c)}
    comments.each { |c| d.comments.create!(c)}
end

leaders_json = ActiveSupport::JSON.decode(File.read('db/seeds/leaders.json'))
leaders_json.each do |ldr|
    Leader.create!(ldr)
end

promotions_json = ActiveSupport::JSON.decode(File.read('db/seeds/promotions.json'))
promotions_json.each do |promo|
    Promotion.create!(promo)
end
