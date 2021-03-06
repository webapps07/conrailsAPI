# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Database (Postgres) config and creation
  - Add postgres dev, test username, pw config in `database.yml` 
  - Creat dbs for dev and test via `rake db:create`

## Add Comment Scaffolding
  - Add `Comment` model and associated files 
    - via `rails g scaffold comment rating:integer, comment:string, author:string`

## Add Dish, Feedback, Promotion and Leader Scaffolding
  - References
    - http://guides.rubyonrails.org/active_record_migrations.html

  - Create migrations
    - `rails g scaffold dish name:string image:string category:string label:string price:string featured:boolean description:string`
    - `rails g scaffold feedback firstname:string lastname:string telnum:integer email:string agree:string contacttype:string message:string`
    - `rails g scaffold promotion name:string image:string label:string price:string featured:boolean description:string`
    - `rails g scaffold leader name:string image:string designation:string abbr:string featured:boolean description:string`
  - Fix migration for `Comment`
    - remove commas from migration for `Comment` model
  - Run migrations via `rake db:migrate`
    - `schema.rb` is generated
    - check database schema in `DBeaver` or equivalent to see changes
  - add `date` to `Comment`
    - add `date` field to `Comment` via `rails g migration AddDateToComments date:datetime`
    - run migrations again via `rake db:migrate`

## Add associations between `Dish` and `Comments`
  - References
    - http://guides.rubyonrails.org/active_record_migrations.html
    - https://stackoverflow.com/questions/17894688/has-many-belongs-to-relation-in-active-record-migration-rails-4
    - https://stackoverflow.com/questions/31450381/has-many-association-migration-in-rails

  - Add `Dish` association to `Comment`
    - add `belongs_to :dish` association in `Comment` model
    - add `has_many :comments` association in `Dish` model
    - generate migration - `rails g migration AddDishRefToComments dish:references`
    - run migration via `rake db:migrate` to update `schema.rb`
    - check database schema in `DBeaver` or equivalent to see association in `UML` diagram
    - open `rails console` and check for `Dish` and `Comment` models

```
irb(main):002:0> Dish.all
  Dish Load (2.5ms)  SELECT  "dishes".* FROM "dishes" LIMIT $1  [["LIMIT", 11]]
=> #<ActiveRecord::Relation []>
irb(main):003:0> Dish.all[0]
  Dish Load (0.0ms)  SELECT "dishes".* FROM "dishes"
=> nil
irb(main):004:0> Comment.all
  Comment Load (4.0ms)  SELECT  "comments".* FROM "comments" LIMIT $1  [["LIMIT", 11]]
=> #<ActiveRecord::Relation []>

```
## Add seed files and import seed data via adding logic in `seeds.rb`
  - References
    - read JSON data - https://gist.github.com/shvetsovdm/6317604
    - https://stackoverflow.com/questions/19822554/seeding-with-a-has-many-relationship
    - https://stackoverflow.com/questions/8551055/how-do-i-seed-a-belongs-to-association
    - create seed data from web url - https://gist.github.com/eToThePiIPower/5951430
    -  https://stackoverflow.com/questions/5010325/in-ruby-on-rails-whats-the-difference-between-create-and-create-and-api-docs
    - https://stackoverflow.com/questions/6227600/how-to-remove-a-key-from-hash-and-get-the-remaining-hash-in-ruby-rails

  - Clear any existing data in DB tables using the below in `DBeaver` Query editor
    - http://www.postgresonline.com/journal/archives/348-DELETE-all-data-really-fast-with-TRUNCATE-TABLE-CASCADE.html
  ```
    truncate table comments;
    truncate table dishes cascade; // for models with associations
    truncate table leaders;
    truncate table promotions;
  ```
  - Create seed JSON files for `Dish, Comment, Leader, Promotion` and copy to `db/seeds`
  - In `seeds.rb` read JSON file and create items for each model via `rake db:seed`
  - Check for data imported in `rails console` and in `DBeaver` data
  - start `rails server` and check for data returned by API end points `localhost:3000/dishes` and `localhost:3000/comments`

### Read `Dish` JSON data from seed files
```
irb(main):009:0> dishes = ActiveSupport::JSON.decode(File.read('db/seeds/dishes.json'))
=> [{"name"=>"Uthappizza", "image"=>"images/uthappizza.png", "category"=>"mains", "label"=>"Hot", "price"=>"4.99", "featured"=>"true", "description"=>"A unique combination of Indian Uthappam (pancake) and Italian pizza, topped with Cerignola olives, ripe vine cherry tomatoes, Vidalia onion, Guntur chillies and Buffalo Paneer.", "comments"=>[{"rating"=>5, "comment"=>"Imagine all the eatables, living in conFusion!", "author"=>"John Lemon", "date"=>"2012-10-16T17:57:28.556094Z"}, {"rating"=>4, "comment"=>"Sends anyone to heaven, I wish I could get my mother-in-law to eat it!", "author"=>"Paul McVites", "date"=>"2014-09-05T17:57:28.556094Z"}, 
.......... ]}]

```

### Create `Dish` and `Comment` from JSON data
```

irb(main):018:0> d = Dish.create!(dishes[0].except("comments"))
   (2.0ms)  BEGIN
  SQL (13.0ms)  INSERT INTO "dishes" ("name", "image", "category", "label", "price", "featured", "description", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING "id"  [["name", "Uthappizza"], ["image", "images/uthappizza.png"], ["category", "mains"], ["label", "Hot"], ["price", "4.99"], ["featured", "t"], ["description", "A unique combination of Indian Uthappam (pancake) and Italian pizza, topped with Cerignola olives, ripe vine cherry tomatoes, Vidalia onion, Guntur chillies and Buffalo Paneer."], ["created_at", "2017-10-31 15:12:34.085838"], ["updated_at", "2017-10-31 15:12:34.085838"]]
   (14.0ms)  COMMIT
=> #<Dish id: 1, name: "Uthappizza", image: "images/uthappizza.png", category: "mains", label: "Hot", price: "4.99", featured: true, description: "A unique combination of Indian Uthappam (pancake) ...", created_at: "2017-10-31 15:12:34", updated_at: "2017-10-31 15:12:34">

irb(main):024:0> dishes[0]["comments"].each { |c| d.comments.create!(c)}
   (1.0ms)  BEGIN
   (1.0ms)  ROLLBACK
   (0.0ms)  BEGIN
  SQL (13.0ms)  INSERT INTO "comments" ("rating", "comment", "author", "created_at", "updated_at", "date", "dish_id") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["rating", 5], ["comment", "Imagine all the eatables, living in conFusion!"], ["author", "John Lemon"], ["created_at", "2017-10-31 16:35:03.872312"], ["updated_at", "2017-10-31 16:35:03.872312"], ["date", "2012-10-16 17:57:28.556094"], ["dish_id", 1]]
   (5.0ms)  COMMIT
   (0.0ms)  BEGIN
   (0.0ms)  ROLLBACK
   (0.0ms)  BEGIN
  SQL (1.0ms)  INSERT INTO "comments" ("rating", "comment", "author", "created_at", "updated_at", "date", "dish_id") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["rating", 4], ["comment", "Sends anyone to heaven, I wish I could get my mother-in-law to eat it!"], ["author", "Paul McVites"], ["created_at", "2017-10-31 16:35:03.927458"], ["updated_at", "2017-10-31 16:35:03.927458"], ["date", "2014-09-05 17:57:28.556094"], ["dish_id", 1]]
   (0.0ms)  COMMIT
   (0.0ms)  BEGIN
   (1.0ms)  ROLLBACK
   (0.0ms)  BEGIN
  SQL (1.0ms)  INSERT INTO "comments" ("rating", "comment", "author", "created_at", "updated_at", "date", "dish_id") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["rating", 3], ["comment", "Eat it, just eat it!"], ["author", "Michael Jaikishan"], ["created_at", "2017-10-31 16:35:03.959543"], ["updated_at", "2017-10-31 16:35:03.959543"], ["date", "2015-02-13 17:57:28.556094"], ["dish_id", 1]]
   (0.0ms)  COMMIT
   (0.0ms)  BEGIN
   (1.0ms)  ROLLBACK
   (0.0ms)  BEGIN
  SQL (0.0ms)  INSERT INTO "comments" ("rating", "comment", "author", "created_at", "updated_at", "date", "dish_id") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["rating", 4], ["comment", "Ultimate, Reaching for the stars!"], ["author", "Ringo Starry"], ["created_at", "2017-10-31 16:35:03.987619"], ["updated_at", "2017-10-31 16:35:03.987619"], ["date", "2013-12-02 17:57:28.556094"], ["dish_id", 1]]
   (0.0ms)  COMMIT
   (1.0ms)  BEGIN
   (0.0ms)  ROLLBACK
   (0.0ms)  BEGIN
  SQL (1.0ms)  INSERT INTO "comments" ("rating", "comment", "author", "created_at", "updated_at", "date", "dish_id") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["rating", 2], ["comment", "It's your birthday, we're gonna party!"], ["author", "25 Cent"], ["created_at", "2017-10-31 16:35:04.022711"], ["updated_at", "2017-10-31 16:35:04.022711"], ["date", "2011-12-02 17:57:28.556094"], ["dish_id", 1]]
   (0.0ms)  COMMIT
   (0.0ms)  BEGIN
   (0.0ms)  ROLLBACK
   (0.0ms)  BEGIN
  SQL (1.0ms)  INSERT INTO "comments" ("rating", "comment", "author", "created_at", "updated_at", "date", "dish_id") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["rating", 4], ["comment", "great dish"], ["author", "Jogesh"], ["created_at", "2017-10-31 16:35:04.053794"], ["updated_at", "2017-10-31 16:35:04.053794"], ["date", "2017-10-30 05:03:39.656000"], ["dish_id", 1]]
   (0.0ms)  COMMIT
=> [{"rating"=>5, "comment"=>"Imagine all the eatables, living in conFusion!", "author"=>"John Lemon", "date"=>"2012-10-16T17:57:28.556094Z"}, {"rating"=>4, "comment"=>"Sends anyone to heaven, I wish I could get my mother-in-law to eat it!", "author"=>"Paul McVites", "date"=>"2014-09-05T17:57:28.556094Z"}, {"rating"=>3, "comment"=>"Eat it, just eat it!", "author"=>"Michael Jaikishan", "date"=>"2015-02-13T17:57:28.556094Z"}, {"rating"=>4, "comment"=>"Ultimate, Reaching for the stars!", "author"=>"Ringo Starry", "date"=>"2013-12-02T17:57:28.556094Z"}, {"rating"=>2, "comment"=>"It's your birthday, we're gonna party!", "author"=>"25 Cent", "date"=>"2011-12-02T17:57:28.556094Z"}, {"author"=>"Jogesh", "rating"=>4, "comment"=>"great dish", "date"=>"2017-10-30T05:03:39.656Z"}]
irb(main):025:0>

```

### Read `Dish` and `Comments` from model
```
irb(main):026:0> Dish.all
  Dish Load (1.0ms)  SELECT  "dishes".* FROM "dishes" LIMIT $1  [["LIMIT", 11]]
=> #<ActiveRecord::Relation [#<Dish id: 1, name: "Uthappizza", image: "images/uthappizza.png", category: "mains", label: "Hot", price: "4.99", featured: true, description: "A unique combination of Indian Uthappam (pancake) ...", created_at: "2017-10-31 15:12:34", updated_at: "2017-10-31 15:12:34">]>
irb(main):027:0> Dish.all.first.comments
  Dish Load (0.0ms)  SELECT  "dishes".* FROM "dishes" ORDER BY "dishes"."id" ASC LIMIT $1  [["LIMIT", 1]]
  Comment Load (1.0ms)  SELECT  "comments".* FROM "comments" WHERE "comments"."dish_id" = $1 LIMIT $2  [["dish_id", 1], ["LIMIT", 11]]
=> #<ActiveRecord::Associations::CollectionProxy [#<Comment id: 1, rating: 5, comment: "Imagine all the eatables, living in conFusion!", author: "John Lemon", created_at: "2017-10-31 16:35:03", updated_at: "2017-10-31 16:35:03", date: "2012-10-16 17:57:28", dish_id: 1>, #<Comment id: 2, rating: 4, comment: "Sends anyone to heaven, I wish I could get my moth...", author: "Paul McVites", created_at: "2017-10-31 16:35:03", updated_at: "2017-10-31 16:35:03", date: "2014-09-05 17:57:28", dish_id: 1>, #<Comment id: 3, rating: 3, comment: "Eat it, just eat it!", author: "Michael Jaikishan", created_at: "2017-10-31 16:35:03", updated_at: "2017-10-31 16:35:03", date: "2015-02-13 17:57:28", dish_id: 1>, #<Comment id: 4, rating: 4, comment: "Ultimate, Reaching for the stars!", author: "Ringo Starry", created_at: "2017-10-31 16:35:03", updated_at: "2017-10-31 16:35:03", date: "2013-12-02 17:57:28", dish_id: 1>, #<Comment id: 5, rating: 2, comment: "It's your birthday, we're gonna party!", author: "25 Cent", created_at: "2017-10-31 16:35:04", updated_at: "2017-10-31 16:35:04", date: "2011-12-02 17:57:28", dish_id: 1>, #<Comment id: 6, rating: 4, comment: "great dish", author: "Jogesh", created_at: "2017-10-31 16:35:04", updated_at: "2017-10-31 16:35:04", date: "2017-10-30 05:03:39", dish_id: 1>]>
irb(main):028:0>

```

### import seed data and check from console
```
C:\apps\railsApi\conFusion>rake db:seed
C:\apps\railsApi\conFusion>
---------------------------------------------------------------
irb(main):066:0> Dish.all.map(&:name)
  Dish Load (14.0ms)  SELECT "dishes".* FROM "dishes"
=> ["Uthappizza", "Zucchipakoda", "Vadonut", "ElaiCheese Cake"]
irb(main):067:0> Dish.all.map(&:id)
  Dish Load (2.0ms)  SELECT "dishes".* FROM "dishes"
=> [9, 10, 11, 12]
irb(main):068:0> Comment.all.map(&:dish_id)
  Comment Load (27.0ms)  SELECT "comments".* FROM "comments"
=> [9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 11, 11, 11, 11, 11, 12, 12, 12, 12, 12]
irb(main):069:0>

```

## Use Active Model Serializer for finer control for API endpoints
  - References
    - https://github.com/rails-api/active_model_serializers/blob/0-10-stable/docs/general/getting_started.md
    - https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-three#toc-serializers
    - https://github.com/rails-api/active_model_serializers/blob/0-10-stable/docs/general/serializers.md

  - add active model serializer to `GemFile` and run `bundle install`
  - fix any `The system cannot find the path specified.` by replacing `emachnic` harlinks in `.bat` files in `C:\RailsInstaller\Ruby2.3.0\bin` following http://stackoverflow.com/a/35680810
  - generate serializer for `Dish` via `rails g serializer dish` which generates `app/serializers/dish_serializer.rb`
  - restart `rails server`
  - check API endpoint `http://localhost:3000/dishes` - by deafult only `id` will be returned for each `Dish`

## Use serializer to customize attributes returned by `/dishes` end point
  - References
    - https://github.com/rails-api/active_model_serializers/blob/0-10-stable/docs/general/getting_started.md
    - https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-three#toc-serializers

  - in `dish_serializer` 
    - specify the `Dish` attributes to be returned by the `/dishes` API end point
    - add `Comment` `has_many` relation - since there is no serializer for comments all attributes for `Comment` model will be included

## Configure Rails to provide data to `conFusion` Angular app by adding and configuring `rack-cors`
  - References
    - https://www.angularonrails.com/getting-started-with-angular-and-rails/
    - https://www.pluralsight.com/guides/ruby-ruby-on-rails/react-vs-angular-2-integration-with-rails
  
  - configure `rails` back-end to allow CORS
    - add `rack-cors` gem to `Gemfile` so as to enable cross-origin HTTP requests (CORS) so that Angular client-side can communicate with the server
    - run `bunlde install`
    - in `/config/initializers/cors.rb` uncomment lines 8 - 16 and modify line 10 to `origins '*'` to allow requests from any origin
  - make images available in rails server
    - in `/public` copy the `images` folder from `json-server/public` so as to server the images from rails server
  - restart the server `rails s -p 3000` to run at port 3000 ( default)
  - start the Angular `conFusion` app which is already configured to send API requests to port 3000 on localhost via setting the `BaseURL`
  - note: getting comments in `dishes/:id` and adding a new comment has issues - to be fixed in next step

## Add Serializer for `Comment` model and return value of `created_at` for `date` attribute
  - References
    - https://stackoverflow.com/questions/47172493/rails-active-model-serializer-attribute-alias/47175502#47175502

  - create `Comment` serializer via `rails g serializer comment`
  - define attributes to return as `:id, :rating, :comment, :author, :date`
  - define `date` method to return the `created_at` attribute
  - check `http://localhost:3000/dishes/:id` - comments in `dishes/:id` will have `date` filled with values of `created_at`

## Remove redundant `date` attr from comments after updating the `created_at` attr to with values of `date` attr
  - References
    - https://stackoverflow.com/questions/47172850/rails-migration-changing-the-attribute-name-of-a-model/47172992#47172992

  - create a new migration via `rails g migration RemoveDateFromComments`
  - define the up and down methods in the migration file
    - define `up` method 
      - for all `Comment` items update the `created_at` attr with value of `date` attr
      - remove `date` attr from model via `remove_column` method
    - define `down` method
      - add `date` attr to the `Comment` model via `add_column` method
      - for all `Comment` items update the `date` atter to take the value of `created_at` attr
