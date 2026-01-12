require_relative "../../test_helper"

module NBA
  class LeagueSeasonMatchupStatTest < Minitest::Test
    cover LeagueSeasonMatchupStat

    def test_equality_based_on_season_id_off_player_id_def_player_id
      stat1 = LeagueSeasonMatchupStat.new(season_id: "22024", off_player_id: 201_939, def_player_id: 203_507)
      stat2 = LeagueSeasonMatchupStat.new(season_id: "22024", off_player_id: 201_939, def_player_id: 203_507)

      assert_equal stat1, stat2
    end

    def test_inequality_with_different_season_id
      stat1 = LeagueSeasonMatchupStat.new(season_id: "22024", off_player_id: 201_939, def_player_id: 203_507)
      stat2 = LeagueSeasonMatchupStat.new(season_id: "22023", off_player_id: 201_939, def_player_id: 203_507)

      refute_equal stat1, stat2
    end

    def test_inequality_with_different_off_player_id
      stat1 = LeagueSeasonMatchupStat.new(season_id: "22024", off_player_id: 201_939, def_player_id: 203_507)
      stat2 = LeagueSeasonMatchupStat.new(season_id: "22024", off_player_id: 201_566, def_player_id: 203_507)

      refute_equal stat1, stat2
    end

    def test_inequality_with_different_def_player_id
      stat1 = LeagueSeasonMatchupStat.new(season_id: "22024", off_player_id: 201_939, def_player_id: 203_507)
      stat2 = LeagueSeasonMatchupStat.new(season_id: "22024", off_player_id: 201_939, def_player_id: 201_566)

      refute_equal stat1, stat2
    end

    def test_season_id_attribute
      stat = LeagueSeasonMatchupStat.new(season_id: "22024")

      assert_equal "22024", stat.season_id
    end

    def test_off_player_id_attribute
      stat = LeagueSeasonMatchupStat.new(off_player_id: 201_939)

      assert_equal 201_939, stat.off_player_id
    end

    def test_off_player_name_attribute
      stat = LeagueSeasonMatchupStat.new(off_player_name: "Stephen Curry")

      assert_equal "Stephen Curry", stat.off_player_name
    end

    def test_def_player_id_attribute
      stat = LeagueSeasonMatchupStat.new(def_player_id: 203_507)

      assert_equal 203_507, stat.def_player_id
    end

    def test_def_player_name_attribute
      stat = LeagueSeasonMatchupStat.new(def_player_name: "Giannis Antetokounmpo")

      assert_equal "Giannis Antetokounmpo", stat.def_player_name
    end

    def test_gp_attribute
      stat = LeagueSeasonMatchupStat.new(gp: 4)

      assert_equal 4, stat.gp
    end

    def test_matchup_min_attribute
      stat = LeagueSeasonMatchupStat.new(matchup_min: 12.5)

      assert_in_delta 12.5, stat.matchup_min
    end

    def test_partial_poss_attribute
      stat = LeagueSeasonMatchupStat.new(partial_poss: 45.2)

      assert_in_delta 45.2, stat.partial_poss
    end

    def test_player_pts_attribute
      stat = LeagueSeasonMatchupStat.new(player_pts: 18.0)

      assert_in_delta 18.0, stat.player_pts
    end

    def test_team_pts_attribute
      stat = LeagueSeasonMatchupStat.new(team_pts: 22.0)

      assert_in_delta 22.0, stat.team_pts
    end

    def test_off_player_returns_player
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)
      stat = LeagueSeasonMatchupStat.new(off_player_id: 201_939)

      assert_instance_of Player, stat.off_player
    end

    def test_off_player_returns_nil_for_nil_id
      stat = LeagueSeasonMatchupStat.new(off_player_id: nil)

      assert_nil stat.off_player
    end

    def test_def_player_returns_player
      stub_request(:get, /commonplayerinfo/).to_return(body: player_response.to_json)
      stat = LeagueSeasonMatchupStat.new(def_player_id: 203_507)

      assert_instance_of Player, stat.def_player
    end

    def test_def_player_returns_nil_for_nil_id
      stat = LeagueSeasonMatchupStat.new(def_player_id: nil)

      assert_nil stat.def_player
    end

    private

    def player_response
      {resultSets: [{name: "CommonPlayerInfo", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_headers
      %w[PERSON_ID DISPLAY_FIRST_LAST BIRTHDATE HEIGHT WEIGHT POSITION JERSEY
        TEAM_ID TEAM_NAME TEAM_ABBREVIATION TEAM_CITY FROM_YEAR TO_YEAR
        GREATEST_75_FLAG ROSTER_STATUS]
    end

    def player_row
      [201_939, "Stephen Curry", "1988-03-14", "6-2", "185", "G", "30",
        Team::GSW, "Warriors", "GSW", "San Francisco", 2009, 2024, "Y", 1]
    end
  end
end
