require_relative "../test_helper"

module NBA
  module FranchisePlayersAllHelper
    PLAYER_HEADERS = %w[LEAGUE_ID TEAM_ID TEAM PERSON_ID PLAYER SEASON_TYPE ACTIVE_WITH_TEAM GP
      FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST PF STL TOV BLK PTS].freeze

    PLAYER_ROW = ["00", Team::GSW, "Golden State Warriors", 201_939, "Stephen Curry", "Regular Season", "Y", 745,
      9.2, 19.3, 0.476, 4.5, 11.2, 0.426, 4.8, 5.3, 0.908, 0.5, 4.5, 5.0, 6.5, 2.1, 1.6, 3.1, 0.2, 24.8].freeze

    def response
      {resultSets: [{name: "FranchisePlayers", headers: PLAYER_HEADERS, rowSet: [PLAYER_ROW]}]}
    end

    def find_first
      FranchisePlayers.all(team: Team::GSW).first
    end
  end
end
