require_relative "../test_helper"

module NBA
  class FantasyProfileStatTest < Minitest::Test
    cover FantasyProfileStat

    def test_player_id
      assert_equal 201_939, FantasyProfileStat.new(player_id: 201_939).player_id
    end

    def test_player_name
      assert_equal "Stephen Curry", FantasyProfileStat.new(player_name: "Stephen Curry").player_name
    end

    def test_team_id
      assert_equal 1_610_612_744, FantasyProfileStat.new(team_id: 1_610_612_744).team_id
    end

    def test_team_abbreviation
      assert_equal "GSW", FantasyProfileStat.new(team_abbreviation: "GSW").team_abbreviation
    end

    def test_fan_duel_pts
      assert_in_delta 45.2, FantasyProfileStat.new(fan_duel_pts: 45.2).fan_duel_pts
    end

    def test_nba_fantasy_pts
      assert_in_delta 52.1, FantasyProfileStat.new(nba_fantasy_pts: 52.1).nba_fantasy_pts
    end

    def test_pts
      assert_in_delta 26.4, FantasyProfileStat.new(pts: 26.4).pts
    end

    def test_reb
      assert_in_delta 5.7, FantasyProfileStat.new(reb: 5.7).reb
    end

    def test_ast
      assert_in_delta 6.1, FantasyProfileStat.new(ast: 6.1).ast
    end

    def test_fg3m
      assert_in_delta 4.3, FantasyProfileStat.new(fg3m: 4.3).fg3m
    end

    def test_fg_pct
      assert_in_delta 0.467, FantasyProfileStat.new(fg_pct: 0.467).fg_pct
    end

    def test_ft_pct
      assert_in_delta 0.917, FantasyProfileStat.new(ft_pct: 0.917).ft_pct
    end

    def test_stl
      assert_in_delta 1.2, FantasyProfileStat.new(stl: 1.2).stl
    end

    def test_blk
      assert_in_delta 0.3, FantasyProfileStat.new(blk: 0.3).blk
    end

    def test_tov
      assert_in_delta 3.1, FantasyProfileStat.new(tov: 3.1).tov
    end

    def test_player
      stat = FantasyProfileStat.new(player_id: 201_939)
      stub_request(:get, /commonplayerinfo.*PlayerID=201939/).to_return(body: player_response.to_json)

      assert_instance_of Player, stat.player
    end

    def test_equality
      stat1 = FantasyProfileStat.new(player_id: 201_939, player_name: "Stephen Curry")
      stat2 = FantasyProfileStat.new(player_id: 201_939, player_name: "Stephen Curry")

      assert_equal stat1, stat2
    end

    def test_inequality_by_player_id
      stat1 = FantasyProfileStat.new(player_id: 201_939, player_name: "Stephen Curry")
      stat2 = FantasyProfileStat.new(player_id: 202_691, player_name: "Stephen Curry")

      refute_equal stat1, stat2
    end

    private

    def player_response
      {resultSets: [{name: "CommonPlayerInfo",
                     headers: %w[PERSON_ID DISPLAY_FIRST_LAST TEAM_ID TEAM_NAME TEAM_ABBREVIATION],
                     rowSet: [[201_939, "Stephen Curry", 1_610_612_744, "Golden State Warriors", "GSW"]]}]}
    end
  end
end
