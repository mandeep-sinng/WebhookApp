## Project Requirements
- Ruby 3.3.2
- Rails 7.0

## Setup
- bundle install
- rails db:setup
- rails s

## Testing
- Goto localhost:300/admin
- Create/Update Data Entries
- Observer the 3rd party APIs (webhook) are being called on each request

## Configuration
- 3rd party API are given in config/third_party_apis.yml
