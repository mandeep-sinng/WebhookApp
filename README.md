## Project Requirements
- Ruby 3.2.2
- Rails 7.0
- redis
- sidekiq

## Setup
- bundle install
- rails db:setup
- rails s
- redis-server
- bundle exec sidekiq

## Testing
- Goto localhost:300/admin
- Create/Update Data Entries
- Observe the 3rd party APIs (webhook) are being called on each request

## Configuration
- 3rd party API are stored in ApiLinks Table
