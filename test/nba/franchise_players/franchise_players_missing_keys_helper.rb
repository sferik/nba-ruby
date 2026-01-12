require_relative "../../test_helper"

module NBA
  module FranchisePlayersMissingKeysHelper
    ALL_HEADERS = %w[LEAGUE_ID TEAM_ID TEAM PERSON_ID PLAYER SEASON_TYPE ACTIVE_WITH_TEAM GP
      FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST PF STL TOV BLK PTS].freeze

    ALL_DATA = {
      "LEAGUE_ID" => "00", "TEAM_ID" => Team::GSW, "TEAM" => "Golden State Warriors",
      "PERSON_ID" => 201_939, "PLAYER" => "Stephen Curry", "SEASON_TYPE" => "Regular Season",
      "ACTIVE_WITH_TEAM" => "Y", "GP" => 745, "FGM" => 9.2, "FGA" => 19.3, "FG_PCT" => 0.476,
      "FG3M" => 4.5, "FG3A" => 11.2, "FG3_PCT" => 0.426, "FTM" => 4.8, "FTA" => 5.3,
      "FT_PCT" => 0.908, "OREB" => 0.5, "DREB" => 4.5, "REB" => 5.0, "AST" => 6.5,
      "PF" => 2.1, "STL" => 1.6, "TOV" => 3.1, "BLK" => 0.2, "PTS" => 24.8
    }.freeze

    def build_response_without(key)
      headers = ALL_HEADERS.reject { |h| h.eql?(key) }
      row = headers.map { |h| ALL_DATA[h] }
      {resultSets: [{name: "FranchisePlayers", headers: headers, rowSet: [row]}]}
    end

    def stub_missing_key(key)
      response = build_response_without(key)
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)
    end

    def find_first
      FranchisePlayers.all(team: Team::GSW).first
    end
  end
end
