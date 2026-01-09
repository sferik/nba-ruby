# NBA Gem

<p align="center">
  <img src="logo.png" alt="NBA Gem Logo">
</p>

[![Tests](https://github.com/sferik/nba-ruby/actions/workflows/test.yml/badge.svg)](https://github.com/sferik/nba-ruby/actions/workflows/test.yml)
[![Linter](https://github.com/sferik/nba-ruby/actions/workflows/lint.yml/badge.svg)](https://github.com/sferik/nba-ruby/actions/workflows/lint.yml)
[![Mutant](https://github.com/sferik/nba-ruby/actions/workflows/mutant.yml/badge.svg)](https://github.com/sferik/nba-ruby/actions/workflows/mutant.yml)
[![Typecheck](https://github.com/sferik/nba-ruby/actions/workflows/typecheck.yml/badge.svg)](https://github.com/sferik/nba-ruby/actions/workflows/typecheck.yml)
[![Docs](https://github.com/sferik/nba-ruby/actions/workflows/docs.yml/badge.svg)](https://github.com/sferik/nba-ruby/actions/workflows/docs.yml)
[![Gem Version](https://badge.fury.io/rb/nba.svg)](https://rubygems.org/gems/nba)

A Ruby interface to the NBA Stats API.

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
teams.size # => 30

# Find the Warriors
warriors = NBA::Teams.find(NBA::Team::GSW)
warriors.full_name   # => "Golden State Warriors"
warriors.city        # => "San Francisco"
warriors.year_founded # => 1946

# Get detailed team information
detail = NBA::TeamDetails.find(team: NBA::Team::GSW)
detail.arena           # => "Chase Center"
detail.owner           # => "Joe Lacob"
detail.general_manager # => "Mike Dunleavy Jr."
detail.head_coach      # => "Steve Kerr"
```

### Players

```ruby
# Get the Warriors roster for 2021-2022
roster = NBA::Roster.find(team: NBA::Team::GSW, season: 2021)
roster.size # => 17

curry = roster.find { |p| p.full_name == "Stephen Curry" }
curry.jersey_number # => 30
curry.height        # => "6-2"
curry.weight        # => 185
curry.college       # => "Davidson"
curry.draft_year    # => 2009
curry.draft_round   # => 1
curry.draft_number  # => 7

# Get Curry's career stats
career = NBA::PlayerCareerStats.find(player: curry)
career.size # => 17

season = career.last
season.pts # => 28.7
season.reb # => 4.0
season.ast # => 4.3

# Get Curry's awards
awards = NBA::PlayerAwards.find(player: curry)
awards.size # => 67

mvps = awards.select { |a| a.description == "NBA Most Valuable Player" }
mvps.size # => 2
```

### Standings

```ruby
# Get current standings
standings = NBA::Standings.all
standings.size # => 30

# Get Western Conference standings for 2021-2022
western = NBA::Standings.conference("West", season: 2021)
western.size # => 15

western.first(3).each do |s|
  puts "#{s.team_name}: #{s.wins}-#{s.losses}"
end
# Suns: 64-18
# Grizzlies: 56-26
# Warriors: 53-29
```

### League Leaders

```ruby
# Get free throw percentage leaders for 2017-2018
NBA::Leaders.find(category: NBA::Leaders::FT_PCT, season: 2017, limit: 5).each do |leader|
  puts "#{leader.rank}. #{leader.player_name}: #{leader.value} FT%"
end
# 1. Stephen Curry: 0.921 FT%
# 2. Damian Lillard: 0.916 FT%
# 3. CJ McCollum: 0.837 FT%
# 4. Kyrie Irving: 0.889 FT%
# 5. Kevin Durant: 0.889 FT%

# Other categories
NBA::Leaders::PTS # Points
NBA::Leaders::REB # Rebounds
NBA::Leaders::AST # Assists
NBA::Leaders::STL # Steals
NBA::Leaders::BLK # Blocks
NBA::Leaders::FG_PCT # Field Goal Percentage
NBA::Leaders::FG3_PCT # Three-Point Percentage
```

### All-Time Leaders

```ruby
# Get all-time points leaders
NBA::AllTimeLeaders.find(category: NBA::AllTimeLeaders::PTS, limit: 5).each do |leader|
  puts "#{leader.rank}. #{leader.player_name}: #{leader.value} points"
end
# 1. LeBron James: 40474 points
# 2. Kareem Abdul-Jabbar: 38387 points
# 3. Karl Malone: 36928 points
# 4. Kobe Bryant: 33643 points
# 5. Michael Jordan: 32292 points

# Get all-time assists leaders
NBA::AllTimeLeaders.find(category: NBA::AllTimeLeaders::AST, limit: 3).each do |leader|
  puts "#{leader.rank}. #{leader.player_name}: #{leader.value} assists"
end

# Available categories
NBA::AllTimeLeaders::PTS # Points
NBA::AllTimeLeaders::AST # Assists
NBA::AllTimeLeaders::REB # Rebounds
NBA::AllTimeLeaders::STL # Steals
NBA::AllTimeLeaders::BLK # Blocks
NBA::AllTimeLeaders::FGM # Field Goals Made
NBA::AllTimeLeaders::FG3M # Three-Pointers Made
```

### Player Info

```ruby
# Get detailed biography for Stephen Curry
info = NBA::CommonPlayerInfo.find(player: 201939)
info.full_name       # => "Stephen Curry"
info.birthdate       # => "1988-03-14"
info.school          # => "Davidson"
info.country         # => "USA"
info.height          # => "6-2"
info.weight          # => 185
info.season_exp      # => 15
info.jersey          # => "30"
info.position        # => "Guard"
info.draft_year      # => 2009
info.draft_round     # => 1
info.draft_number    # => 7
info.greatest_75?    # => true

# Get current team info
info.team.full_name  # => "Golden State Warriors"
```

### League Team Stats

```ruby
# Get league-wide team statistics for 2024-2025
stats = NBA::LeagueDashTeamStats.find(season: 2024)

# Find the Warriors
gsw = stats.find { |s| s.team_abbreviation == "GSW" }
gsw.gp        # => 82 (games played)
gsw.wins      # => 46
gsw.losses    # => 36
gsw.pts       # => 118.9 (points per game)
gsw.reb       # => 44.2 (rebounds per game)
gsw.ast       # => 28.7 (assists per game)
gsw.fg_pct    # => 0.478 (field goal percentage)
gsw.fg3_pct   # => 0.378 (three-point percentage)

# Sort by points per game
top_offenses = stats.sort_by(&:pts).reverse.first(5)
top_offenses.each do |team|
  puts "#{team.team_name}: #{team.pts} PPG"
end
```

### Team History

```ruby
# Get all seasons the Warriors have played
years = NBA::CommonTeamYears.find(team: NBA::Team::GSW)
years.size # => 79

year = years.first
year.team_id     # => 1610612744
year.year        # => 2024
year.season      # => "2024-25"
year.min_year    # => 1946
year.max_year    # => 2024
year.abbreviation # => "GSW"
```

### Player Game Logs

```ruby
# Get Curry's game log for 2025-2026
logs = NBA::PlayerGameLog.find(player: 201939, season: 2025)

log = logs.last # Season opener
log.game_date # => "Oct 21, 2025"
log.matchup   # => "GSW @ LAL"
log.pts       # => 23
log.reb       # => 1
log.ast       # => 4

# Get playoffs game log
playoff_logs = NBA::PlayerGameLog.find(
  player: 201939,
  season: 2025,
  season_type: NBA::PlayerGameLog::PLAYOFFS
)
```

### Box Scores

```ruby
# Get team stats from 2025-2026 season opener: Warriors vs Lakers
game = "0022500061"
teams = NBA::BoxScoreTraditional.team_stats(game: game)

gsw = teams.find { |t| t.team_abbreviation == "GSW" }
lal = teams.find { |t| t.team_abbreviation == "LAL" }

# Final score
puts "#{gsw.team_name}: #{gsw.pts}"  # => "Warriors: 118"
puts "#{lal.team_name}: #{lal.pts}"  # => "Lakers: 109"

# Team shooting comparison
gsw.fg_pct  # => 0.477 (47.7% FG)
gsw.fg3_pct # => 0.395 (39.5% 3PT)
gsw.ft_pct  # => 0.850 (85.0% FT)

# Team rebounding
gsw.oreb # => 10  (offensive rebounds)
gsw.dreb # => 35  (defensive rebounds)
gsw.reb  # => 45  (total rebounds)

# Other team stats
gsw.ast # => 28  (assists)
gsw.tov # => 14  (turnovers)
gsw.stl # => 9   (steals)
gsw.blk # => 6   (blocks)
```

### Game Rotations

```ruby
# Get rotation data for 2025-2026 season opener
game = "0022500061"
rotations = NBA::GameRotation.home_team(game: game)
rotations.size # => 42

# Find Curry's stints
curry_stints = rotations.select { |r| r.player_last == "Curry" }
curry_stints.size # => 6

stint = curry_stints.first
stint.player_name  # => "Stephen Curry"
stint.player_pts   # => 8
stint.pt_diff      # => 7
stint.in_time_real # => 0
```

### Hustle Stats

```ruby
# Get hustle stats for a game
game = "0022400001"

# Player hustle stats
player_stats = NBA::BoxScoreHustle.player_stats(game: game)
curry = player_stats.find { |p| p.player_name == "Stephen Curry" }
curry.minutes           # => "34:22"
curry.contested_shots   # => 5
curry.deflections       # => 3
curry.loose_balls_recovered # => 2
curry.screen_assists    # => 8
curry.starter?          # => true

# Team hustle stats
team_stats = NBA::BoxScoreHustle.team_stats(game: game)
gsw = team_stats.find { |t| t.team_abbreviation == "GSW" }
gsw.contested_shots     # => 42
gsw.deflections         # => 15
gsw.loose_balls_recovered # => 8
```

### Player Tracking Stats

```ruby
# Get player tracking stats for a game
game = "0022400001"

# Player tracking data
player_stats = NBA::BoxScorePlayerTrack.player_stats(game: game)
curry = player_stats.find { |p| p.player_name == "Stephen Curry" }
curry.speed             # => 4.52 (mph)
curry.distance          # => 2.85 (miles)
curry.touches           # => 75
curry.passes            # => 48
curry.secondary_ast     # => 3
curry.front_court_touches # => 62

# Team tracking data
team_stats = NBA::BoxScorePlayerTrack.team_stats(game: game)
gsw = team_stats.find { |t| t.team_abbreviation == "GSW" }
gsw.distance            # => 12.5 (team miles)
gsw.passes              # => 285
```

### Game Summary

```ruby
# Get comprehensive game summary
game = "0022400001"
summary = NBA::BoxScoreSummaryV2.find(game: game)

# Game info
summary.game_date        # => "2024-10-22"
summary.game_status_text # => "Final"
summary.arena            # => "Chase Center"
summary.attendance       # => 18064

# Score by quarter
summary.home_pts_q1      # => 28
summary.home_pts_q2      # => 32
summary.home_pts_q3      # => 25
summary.home_pts_q4      # => 33
summary.home_pts         # => 118

summary.visitor_pts_q1   # => 25
summary.visitor_pts      # => 109

# Other details
summary.officials        # => ["Scott Foster", "Tony Brothers", "Courtney Kirkland"]
summary.lead_changes     # => 12
summary.times_tied       # => 8

# Game status helpers
summary.final?           # => true
summary.in_progress?     # => false
summary.scheduled?       # => false

# Related objects
summary.home_team.full_name    # => "Golden State Warriors"
summary.visitor_team.full_name # => "Los Angeles Lakers"
```

### Schedule

```ruby
require "date"

# Get Warriors schedule for 2025-2026
schedule = NBA::Schedule.by_team(team: NBA::Team::GSW, season: 2025)
schedule.size # => 101

# Find opening night game (stored in UTC)
opener = schedule.find { |g| g.game_date&.start_with?("2025-10-22") }
opener.away_team_tricode # => "LAL"
opener.home_team_tricode # => "GSW"
opener.arena_name        # => "Chase Center"
```

### Franchise History

```ruby
# Get all franchise histories
history = NBA::FranchiseHistory.all
history.size # => 74

# Find Warriors history
gsw = history.find { |h| h.team_id == NBA::Team::GSW }
gsw.start_year     # => 1946
gsw.wins           # => 3035
gsw.losses         # => 3184
gsw.po_appearances # => 38
gsw.league_titles  # => 7

# Get defunct franchises
defunct = NBA::FranchiseHistory.defunct
defunct.size # => 15
```

## TODO

The following endpoints are not yet implemented:

### Draft Endpoints
- [ ] DraftBoard
- [ ] DraftCombineDrillResults
- [ ] DraftCombineNonStationaryShooting
- [ ] DraftCombinePlayerAnthro
- [ ] DraftCombineSpotShooting
- [ ] DraftCombineStats

### Cumulative Stats Endpoints
- [ ] CumeStatsPlayer
- [ ] CumeStatsPlayerGames
- [ ] CumeStatsTeam
- [ ] CumeStatsTeamGames

### Franchise Endpoints
- [ ] FranchiseLeaders
- [ ] FranchisePlayers

### Video Endpoints
- [ ] VideoDetails
- [ ] VideoDetailsAsset
- [ ] VideoEvents
- [ ] VideoStatus

### Other Endpoints
- [ ] AssistLeaders
- [ ] AssistTracker
- [ ] DefenseHub
- [ ] FantasyWidget
- [ ] HomePageLeaders
- [ ] HomePageV2
- [ ] HustleStatsBoxScore
- [ ] IstStandings (In-Season Tournament)
- [ ] LeadersTiles
- [ ] MatchupsRollup
- [ ] PlayByPlayV3
- [ ] PlayoffPicture
- [ ] ScoreboardV3
- [ ] ShotChartLineupDetail

### Live Data Endpoints
- [ ] Live Odds

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
