# NZBN Ruby

A Ruby gem for interacting with the New Zealand Business Number (NZBN) API v5.

[![Gem Version](https://badge.fury.io/rb/nzbn-ruby.svg)](https://badge.fury.io/rb/nzbn-ruby)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nzbn-ruby'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install nzbn-ruby
```

## Requirements

- ...

## Configuration

Configure the gem with your NZBN API key (obtain from [api.business.govt.nz](https://api.business.govt.nz)):

```ruby
Nzbn.configure do |config|
  config.api_key = 'your-api-key'
  config.base_url = 'https://api.business.govt.nz/gateway/nzbn/v5'  # default
  config.timeout = 30  # optional, default 30 seconds
end
```

## Usage

### Initialize the Client

```ruby
client = Nzbn::Client.new

# Or with inline configuration
client = Nzbn::Client.new(api_key: 'your-api-key')
```

### Search Entities

```ruby
# Search by name
results = client.entities.search(search_term: 'Company Name')

results.each do |entity|
  puts "#{entity.entity_name} (#{entity.nzbn})"
end

# With filters
results = client.entities.search(
  search_term: 'Wellington',
  entity_status: 'Registered',
  entity_type: 'NZCompany',
  page: 0,
  page_size: 20
)
```

### Get Entity Details

```ruby
entity = client.entities.get(nzbn: '9429041925676')

puts entity.entity_name
puts entity.entity_status_description
puts entity.registration_date
```

### Entity Change History

```ruby
# Search for changes
changes = client.entities.changes(
  change_event_type: 'ALL',
  date_time_from: '2024-01-01T00:00:00',
  date_time_to: '2024-12-31T23:59:59'
)
```

### Manage Addresses

```ruby
# List addresses
addresses = client.addresses.list(nzbn: '9429041925676')

# Add an address
new_address = client.addresses.create(
  nzbn: '9429041925676',
  address: {
    addressType: 'POSTAL',
    address1: '123 Main Street',
    address2: 'Wellington',
    postCode: '6011',
    countryCode: 'NZ'
  }
)
```

### Manage Roles

```ruby
# List roles (directors, partners, etc.)
roles = client.roles.list(nzbn: '9429041925676')

roles.each do |role|
  puts "#{role.role_type}: #{role.role_person&.first_name} #{role.role_person&.last_name}"
end
```

### Trading Names

```ruby
trading_names = client.trading_names.list(nzbn: '9429041925676')
```

### Watchlists

```ruby
# Create a watchlist for change notifications
watchlist = client.watchlists.create(watchlist: {
  name: 'My Watchlist',
  channel: 'EMAIL',
  frequency: 'DAILY',
  changeEventTypes: 'ALL',
  adminEmailAddress: 'admin@example.com'
})

# Add NZBNs to watch
client.watchlists.add_nzbns(
  watchlist_id: watchlist.watchlist_id,
  nzbns: ['9429041925676', '9429000001234']
)

# List watchlists
my_watchlists = client.watchlists.list
```

### Privacy Settings

```ruby
# Get privacy settings
settings = client.privacy_settings.get(nzbn: '9429041925676')

# Update privacy settings
client.privacy_settings.update(
  nzbn: '9429041925676',
  settings: { phonePrivateInformation: true }
)
```

### Company Details

```ruby
# Get company-specific details
company = client.company_details.get(nzbn: '9429041925676')

puts company.annual_return_filing_month
puts company.has_constitution_filed
```

### History

```ruby
# Get historical data
historical_names = client.history.entity_names(nzbn: '9429041925676')
historical_addresses = client.history.addresses(nzbn: '9429041925676')
```

## Error Handling

```ruby
begin
  entity = client.entities.get(nzbn: 'invalid')
rescue Nzbn::NotFoundError => e
  puts "Entity not found"
rescue Nzbn::AuthenticationError => e
  puts "Invalid API key"
rescue Nzbn::ValidationError => e
  puts "Invalid request: #{e.message}"
  e.errors.each { |err| puts "  #{err['field']}: #{err['message']}" }
rescue Nzbn::ApiError => e
  puts "API error: #{e.message} (#{e.error_code})"
end
```

## API Resources

| Resource | Description |
|----------|-------------|
| `entities` | Search, get, create entities |
| `addresses` | Manage entity addresses |
| `roles` | Manage directors, partners, etc. |
| `trading_names` | Manage trading names |
| `phone_numbers` | Manage phone numbers |
| `email_addresses` | Manage email addresses |
| `websites` | Manage websites |
| `industry_classifications` | Manage ANZSIC codes |
| `privacy_settings` | Manage privacy settings |
| `company_details` | Get company/non-company details |
| `watchlists` | Manage change notification watchlists |
| `organisation_parts` | Manage OPN/GLN |
| `history` | Access historical data |

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests.

```bash
bundle install
bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Links

- [NZBN API Documentation](https://api.business.govt.nz/api/nzbn)
- [API Explorer](https://api.business.govt.nz)
