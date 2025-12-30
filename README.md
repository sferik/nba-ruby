# NBA Ruby

[![Gem Version](https://badge.fury.io/rb/nba.svg)](https://rubygems.org/gems/nba)

A Ruby interface to the NBA Stats API. This library provides an object-oriented interface to NBA.com's statistics API.

## Installation

Install the gem:

```bash
gem install nba
```

Or add it to your Gemfile:

```ruby
gem "nba"
```

## Usage

### Teams

```ruby
require "nba"

# Create a team instance
lakers = NBA::Team.new(id: NBA::Team::LAL, name: "Los Angeles Lakers")

# Access team constants
celtics_id = NBA::Team::BOS
```

### Players

```ruby
# Create a player instance
lebron = NBA::Player.new(
  id: 2544,
  full_name: "LeBron James",
  jersey_number: 23
)

# Check if player is active
lebron.active? # => true
```

### Collections

```ruby
# Create a collection of players
players = NBA::Collection.new([player1, player2, player3])

# Iterate over collection
players.each { |player| puts player.full_name }

# Get collection size
players.size # => 3
```

## Development

After checking out the repo, run `bundle install` to install dependencies.

### Running Tests

```bash
bundle exec rake test
```

### Running Linters

```bash
bundle exec rake lint
```

### Running Mutant (Mutation Testing)

```bash
bundle exec rake mutant
```

### Running Type Checker

```bash
bundle exec rake steep
```

### Generating Documentation

```bash
bundle exec rake yard
```

### Running All Quality Checks

```bash
bundle exec rake
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sferik/nba-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
