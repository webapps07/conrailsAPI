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

