# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version ruby-2.6.5

* Rails version 6

* Run below commants in sequense to setup project
  * bundle install 
  * yarn

Note: Use nvm version 14.17.4  

* Database creation
  rake db:create

* Database initialization
  rake db:migrate

* Start the server
  rails server
  
* To import admins  
  rake import:admins

* To import merchants
  rake import:merchants  

Note: I have added postman collection file for testing, Please have a look on it for api request payment_processor.postman_collection.json