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

# Get all NBA teams
teams = NBA::Teams.all
teams.each { |team| puts team.name }

# Find a specific team
warriors = NBA::Teams.find(NBA::Team::GSW)
warriors.name         #=> "Golden State Warriors"
warriors.city         #=> "San Francisco"
warriors.year_founded #=> 1946

### Players

```ruby
# Get all current players
players = NBA::Players.all

# Get all players (including inactive)
all_players = NBA::Players.all(only_current: false)

# Get players for a specific season
players_2023 = NBA::Players.all(season: 2023)

# Find a specific player from the roster by jersey number
warriors_roster = NBA::Roster.find(team: NBA::Team::GSW, season: 2023)
curry = warriors_roster.find { |p| p.jersey_number == 30 }

# Or find by name
curry = warriors_roster.find { |p| p.full_name == "Stephen Curry" }

# Get detailed player info
player = NBA::Players.find(curry.id)
player.first_name   #=> "Stephen"
player.last_name    #=> "Curry"
player.height       #=> "6-2"
player.weight       #=> 185
player.college      #=> "Davidson"
player.country      #=> "USA"
player.draft_year   #=> 2009
player.draft_round  #=> 1
player.draft_number #=> 7
```

### Scoreboard

```ruby
require "date"

# Get today's games
games = NBA::Scoreboard.games
games.each do |game|
  puts "#{game.away_team.name} @ #{game.home_team.name}: #{game.away_score}-#{game.home_score}"
end

# Get games for a specific date
games = NBA::Scoreboard.games(date: Date.new(2025, 10, 21))
games.each do |game|
  puts "#{game.status}: #{game.away_team.abbreviation} vs #{game.home_team.abbreviation}"
  puts "Arena: #{game.arena}"
end
```

### Leaders

```ruby
# Get scoring leaders
scoring_leaders = NBA::Leaders.find(category: NBA::Leaders::PTS)
scoring_leaders.each do |leader|
  puts "#{leader.rank}. #{leader.player_name} (#{leader.team_abbreviation}): #{leader.value} PPG"
end

# Get top 5 free throw percentage leaders for the 2023 season
ft_leaders = NBA::Leaders.find(category: NBA::Leaders::FT_PCT, season: 2023, limit: 5)
```

### Standings

```ruby
# Get all standings
standings = NBA::Standings.all
standings.each do |standing|
  puts "#{standing.conference_rank}. #{standing.team_name}: #{standing.wins}-#{standing.losses}"
end

# Get Western Conference standings
western = NBA::Standings.conference("West")
western.each do |standing|
  puts "#{standing.team_name}: #{standing.wins}-#{standing.losses} (#{standing.win_pct})"
  puts "  Home: #{standing.home_record}, Road: #{standing.road_record}"
  puts "  Streak: #{standing.streak}"
end

# Get standings for a specific season
standings_2023 = NBA::Standings.all(season: 2023)
```

### Collections

All methods that return multiple items return an `NBA::Collection`:

```ruby
teams = NBA::Teams.all
teams.size        #=> 30
teams.length      #=> 30
teams.count       #=> 30
teams.first       #=> #<NBA::Team>
teams.each { |t| puts t.name }
teams.map(&:abbreviation) #=> ["ATL", "BOS", ...]
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
