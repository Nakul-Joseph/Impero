# README
## Impero take home assesment

1. Set Temperature definitions for hot and cold temperatures.
2. Search postcode in field provided to know the temperature of the location - Hot, Warm or Cold? based on the max temperature.

### Ruby version : 2.6.6
### Rails version : 6.1.3
### Node version : 10.24.0
### Nodejs version : 14.16.0

Run **bundle install** to install all required gems.

### Database creation
Use **rails db:create**.

### Database initialization
Use **rails db:migrate** ('RAILS_ENV=test' to run migration in test env).

### Database seed
Use **rails db:seed**

### Test
Tests written using RSpec can be run using **bundle exec rspec** or simply **rspec**.

 - To run model specs: **bundle exec rspec spec/models**
 - To run request specs:  **bundle exec rspec spec/requests**
### Run
Run application using **rails s**

### DB
To keep things simple **sqlite** database is used as it is lightweight, fast, reliable and requires no maintenance/configuration.

### Debugging
Added [**pry-byebug**]([https://github.com/deivid-rodriguez/pry-byebug](https://github.com/deivid-rodriguez/pry-byebug)) gem for debugging in development and test environment and can be invoked using **binding.pry**.

### Test support
Using [**factory_bot_rails**]([https://github.com/thoughtbot/factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)) and [**shoulda-matchers**]([https://github.com/thoughtbot/shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)) to help with tesing using RSpec.

### Could have done
- Add admin user and give admin privilege to add temperature definitions.
- Refactor code.
- Additional specs for more coverage.