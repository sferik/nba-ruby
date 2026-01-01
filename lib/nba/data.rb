require "json"
require_relative "client"
require_relative "team"

module NBA
  # Provides static team data for all 30 NBA teams
  module Data
    # All NBA team data with complete information
    # @return [Array<Hash>] array of team hashes
    TEAMS = [
      {id: Team::ATL, abbreviation: "ATL", name: "Atlanta Hawks", full_name: "Atlanta Hawks", nickname: "Hawks",
       city: "Atlanta", state: "Georgia", year_founded: 1946},
      {id: Team::BOS, abbreviation: "BOS", name: "Boston Celtics", full_name: "Boston Celtics", nickname: "Celtics",
       city: "Boston", state: "Massachusetts", year_founded: 1946},
      {id: Team::BKN, abbreviation: "BKN", name: "Brooklyn Nets", full_name: "Brooklyn Nets", nickname: "Nets",
       city: "Brooklyn", state: "New York", year_founded: 1967},
      {id: Team::CHA, abbreviation: "CHA", name: "Charlotte Hornets", full_name: "Charlotte Hornets", nickname: "Hornets",
       city: "Charlotte", state: "North Carolina", year_founded: 1988},
      {id: Team::CHI, abbreviation: "CHI", name: "Chicago Bulls", full_name: "Chicago Bulls", nickname: "Bulls",
       city: "Chicago", state: "Illinois", year_founded: 1966},
      {id: Team::CLE, abbreviation: "CLE", name: "Cleveland Cavaliers", full_name: "Cleveland Cavaliers", nickname: "Cavaliers",
       city: "Cleveland", state: "Ohio", year_founded: 1970},
      {id: Team::DAL, abbreviation: "DAL", name: "Dallas Mavericks", full_name: "Dallas Mavericks", nickname: "Mavericks",
       city: "Dallas", state: "Texas", year_founded: 1980},
      {id: Team::DEN, abbreviation: "DEN", name: "Denver Nuggets", full_name: "Denver Nuggets", nickname: "Nuggets",
       city: "Denver", state: "Colorado", year_founded: 1967},
      {id: Team::DET, abbreviation: "DET", name: "Detroit Pistons", full_name: "Detroit Pistons", nickname: "Pistons",
       city: "Detroit", state: "Michigan", year_founded: 1941},
      {id: Team::GSW, abbreviation: "GSW", name: "Golden State Warriors", full_name: "Golden State Warriors", nickname: "Warriors",
       city: "San Francisco", state: "California", year_founded: 1946},
      {id: Team::HOU, abbreviation: "HOU", name: "Houston Rockets", full_name: "Houston Rockets", nickname: "Rockets",
       city: "Houston", state: "Texas", year_founded: 1967},
      {id: Team::IND, abbreviation: "IND", name: "Indiana Pacers", full_name: "Indiana Pacers", nickname: "Pacers",
       city: "Indianapolis", state: "Indiana", year_founded: 1967},
      {id: Team::LAC, abbreviation: "LAC", name: "LA Clippers", full_name: "Los Angeles Clippers", nickname: "Clippers",
       city: "Los Angeles", state: "California", year_founded: 1970},
      {id: Team::LAL, abbreviation: "LAL", name: "Los Angeles Lakers", full_name: "Los Angeles Lakers", nickname: "Lakers",
       city: "Los Angeles", state: "California", year_founded: 1947},
      {id: Team::MEM, abbreviation: "MEM", name: "Memphis Grizzlies", full_name: "Memphis Grizzlies", nickname: "Grizzlies",
       city: "Memphis", state: "Tennessee", year_founded: 1995},
      {id: Team::MIA, abbreviation: "MIA", name: "Miami Heat", full_name: "Miami Heat", nickname: "Heat",
       city: "Miami", state: "Florida", year_founded: 1988},
      {id: Team::MIL, abbreviation: "MIL", name: "Milwaukee Bucks", full_name: "Milwaukee Bucks", nickname: "Bucks",
       city: "Milwaukee", state: "Wisconsin", year_founded: 1968},
      {id: Team::MIN, abbreviation: "MIN", name: "Minnesota Timberwolves", full_name: "Minnesota Timberwolves", nickname: "Timberwolves",
       city: "Minneapolis", state: "Minnesota", year_founded: 1989},
      {id: Team::NOP, abbreviation: "NOP", name: "New Orleans Pelicans", full_name: "New Orleans Pelicans", nickname: "Pelicans",
       city: "New Orleans", state: "Louisiana", year_founded: 2002},
      {id: Team::NYK, abbreviation: "NYK", name: "New York Knicks", full_name: "New York Knicks", nickname: "Knicks",
       city: "New York", state: "New York", year_founded: 1946},
      {id: Team::OKC, abbreviation: "OKC", name: "Oklahoma City Thunder", full_name: "Oklahoma City Thunder", nickname: "Thunder",
       city: "Oklahoma City", state: "Oklahoma", year_founded: 1967},
      {id: Team::ORL, abbreviation: "ORL", name: "Orlando Magic", full_name: "Orlando Magic", nickname: "Magic",
       city: "Orlando", state: "Florida", year_founded: 1989},
      {id: Team::PHI, abbreviation: "PHI", name: "Philadelphia 76ers", full_name: "Philadelphia 76ers", nickname: "76ers",
       city: "Philadelphia", state: "Pennsylvania", year_founded: 1946},
      {id: Team::PHX, abbreviation: "PHX", name: "Phoenix Suns", full_name: "Phoenix Suns", nickname: "Suns",
       city: "Phoenix", state: "Arizona", year_founded: 1968},
      {id: Team::POR, abbreviation: "POR", name: "Portland Trail Blazers", full_name: "Portland Trail Blazers", nickname: "Trail Blazers",
       city: "Portland", state: "Oregon", year_founded: 1970},
      {id: Team::SAC, abbreviation: "SAC", name: "Sacramento Kings", full_name: "Sacramento Kings", nickname: "Kings",
       city: "Sacramento", state: "California", year_founded: 1945},
      {id: Team::SAS, abbreviation: "SAS", name: "San Antonio Spurs", full_name: "San Antonio Spurs", nickname: "Spurs",
       city: "San Antonio", state: "Texas", year_founded: 1967},
      {id: Team::TOR, abbreviation: "TOR", name: "Toronto Raptors", full_name: "Toronto Raptors", nickname: "Raptors",
       city: "Toronto", state: "Ontario", year_founded: 1995},
      {id: Team::UTA, abbreviation: "UTA", name: "Utah Jazz", full_name: "Utah Jazz", nickname: "Jazz",
       city: "Salt Lake City", state: "Utah", year_founded: 1974},
      {id: Team::WAS, abbreviation: "WAS", name: "Washington Wizards", full_name: "Washington Wizards", nickname: "Wizards",
       city: "Washington", state: "District of Columbia", year_founded: 1961}
    ].freeze
  end
end
