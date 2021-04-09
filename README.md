# Warehouse Product Routing

## Introduction

Sample application to determine the routing process of a product in a warehouse.

## Prerequisites

You should have the following installed to be able to test this application locally:
* rvm or rbenv
* ruby 2.6.6
* Rails 6.1.3
* PostgreSQL >= 12
* node
* yarn

## Installation

* Install RVM (Ruby Version Manager).

  `curl -L https://get.rvm.io | bash -s stable`

* Install Ruby

  `rvm use install ruby-2.6.6`

* Install Bundler (gem management tool).
  ```
  gem install bundler
  ```

* Clone the application and install dependencies
   
   ```
   git clone https://github.com/warrenchaudhry/warehouse-routing.git`
   cd warehouse-routing
   bundle install
   yarn install --check-files
   ```
  
* Initialize local development database
  
  Copy the file `config/application.yml.example` and rename it to `config/application.yml`, then update your database credentials

  ```
  DB_USERNAME: db_username
  DB_PASSWORD: db_password
  ```
  
  * Create and setup the database
    ```
    rails db:create && rails db:migrate
    ```
    

## Run the application
* `rails s`

## Run the tests
* `rspec`

