require_relative "../test_helper"

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

  class FranchisePlayersMissingKeysIdentityTest < Minitest::Test
    include FranchisePlayersMissingKeysHelper

    cover FranchisePlayers

    def test_all_handles_missing_league_id
      stub_missing_key("LEAGUE_ID")

      assert_nil find_first.league_id
    end

    def test_all_handles_missing_team_id
      stub_missing_key("TEAM_ID")

      assert_nil find_first.team_id
    end

    def test_all_handles_missing_team
      stub_missing_key("TEAM")

      assert_nil find_first.team
    end

    def test_all_handles_missing_person_id
      stub_missing_key("PERSON_ID")

      assert_nil find_first.person_id
    end

    def test_all_handles_missing_player
      stub_missing_key("PLAYER")

      assert_nil find_first.player
    end

    def test_all_handles_missing_season_type
      stub_missing_key("SEASON_TYPE")

      assert_nil find_first.season_type
    end

    def test_all_handles_missing_active_with_team
      stub_missing_key("ACTIVE_WITH_TEAM")

      assert_nil find_first.active_with_team
    end

    def test_all_handles_missing_gp
      stub_missing_key("GP")

      assert_nil find_first.gp
    end
  end

  class FranchisePlayersMissingKeysShotTest < Minitest::Test
    include FranchisePlayersMissingKeysHelper

    cover FranchisePlayers

    def test_all_handles_missing_fgm
      stub_missing_key("FGM")

      assert_nil find_first.fgm
    end

    def test_all_handles_missing_fga
      stub_missing_key("FGA")

      assert_nil find_first.fga
    end

    def test_all_handles_missing_fg_pct
      stub_missing_key("FG_PCT")

      assert_nil find_first.fg_pct
    end

    def test_all_handles_missing_fg3m
      stub_missing_key("FG3M")

      assert_nil find_first.fg3m
    end

    def test_all_handles_missing_fg3a
      stub_missing_key("FG3A")

      assert_nil find_first.fg3a
    end

    def test_all_handles_missing_fg3_pct
      stub_missing_key("FG3_PCT")

      assert_nil find_first.fg3_pct
    end

    def test_all_handles_missing_ftm
      stub_missing_key("FTM")

      assert_nil find_first.ftm
    end

    def test_all_handles_missing_fta
      stub_missing_key("FTA")

      assert_nil find_first.fta
    end

    def test_all_handles_missing_ft_pct
      stub_missing_key("FT_PCT")

      assert_nil find_first.ft_pct
    end
  end

  class FranchisePlayersMissingKeysOtherTest < Minitest::Test
    include FranchisePlayersMissingKeysHelper

    cover FranchisePlayers

    def test_all_handles_missing_oreb
      stub_missing_key("OREB")

      assert_nil find_first.oreb
    end

    def test_all_handles_missing_dreb
      stub_missing_key("DREB")

      assert_nil find_first.dreb
    end

    def test_all_handles_missing_reb
      stub_missing_key("REB")

      assert_nil find_first.reb
    end

    def test_all_handles_missing_ast
      stub_missing_key("AST")

      assert_nil find_first.ast
    end

    def test_all_handles_missing_pf
      stub_missing_key("PF")

      assert_nil find_first.pf
    end

    def test_all_handles_missing_stl
      stub_missing_key("STL")

      assert_nil find_first.stl
    end

    def test_all_handles_missing_tov
      stub_missing_key("TOV")

      assert_nil find_first.tov
    end

    def test_all_handles_missing_blk
      stub_missing_key("BLK")

      assert_nil find_first.blk
    end

    def test_all_handles_missing_pts
      stub_missing_key("PTS")

      assert_nil find_first.pts
    end
  end
end
