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
- Goto localhost:3000/admin
- Add ApiLinks
- Create/Update Data Entries
- Observe the 3rd party APIs (webhook) are being called on each request (through rails logs)
- Observe the Sidekiq UI to see the jobs are running localhost:3000/sidekiq

## Configuration
- 3rd party API are stored in ApiLinks Table
