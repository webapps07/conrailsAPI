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