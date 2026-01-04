require_relative "../test_helper"

module NBA
  class PlayTypeStatTest < Minitest::Test
    cover PlayTypeStat

    def test_equality_based_on_player_id_play_type_and_type_grouping
      stat1 = PlayTypeStat.new(player_id: 201_939, play_type: "Isolation", type_grouping: "offensive")
      stat2 = PlayTypeStat.new(player_id: 201_939, play_type: "Isolation", type_grouping: "offensive")
      stat3 = PlayTypeStat.new(player_id: 201_939, play_type: "Transition", type_grouping: "offensive")
      stat4 = PlayTypeStat.new(player_id: 201_939, play_type: "Isolation", type_grouping: "defensive")
      stat5 = PlayTypeStat.new(player_id: 2544, play_type: "Isolation", type_grouping: "offensive")

      assert_equal stat1, stat2
      refute_equal stat1, stat3
      refute_equal stat1, stat4
      refute_equal stat1, stat5
    end

    def test_player_returns_player_object
      stub_request(:get, /commonplayerinfo.*PlayerID=201939/)
        .to_return(body: player_info_response.to_json)
      stat = PlayTypeStat.new(player_id: 201_939)

      assert_equal 201_939, stat.player.id
    end

    def test_team_returns_team_object
      stat = PlayTypeStat.new(team_id: Team::GSW)
      team = stat.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_offensive_returns_true_when_type_grouping_is_offensive
      stat = PlayTypeStat.new(type_grouping: "offensive")

      assert_predicate stat, :offensive?
      refute_predicate stat, :defensive?
    end

    def test_defensive_returns_true_when_type_grouping_is_defensive
      stat = PlayTypeStat.new(type_grouping: "defensive")

      assert_predicate stat, :defensive?
      refute_predicate stat, :offensive?
    end

    def test_basic_identifiers_assignable
      stat = sample_stat

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Isolation", stat.play_type
    end

    def test_game_and_possession_stats_assignable
      stat = sample_stat

      assert_equal "offensive", stat.type_grouping
      assert_equal 82, stat.gp
      assert_equal 250, stat.poss
      assert_in_delta 0.085, stat.poss_pct
      assert_equal 300, stat.pts
    end

    def test_points_and_field_goal_stats_assignable
      stat = sample_stat

      assert_in_delta 0.095, stat.pts_pct
      assert_equal 100, stat.fgm
      assert_equal 200, stat.fga
      assert_in_delta 0.500, stat.fg_pct
      assert_in_delta 0.575, stat.efg_pct
    end

    def test_possession_percentage_stats_assignable
      stat = sample_stat

      assert_in_delta 0.120, stat.ft_poss_pct
      assert_in_delta 0.080, stat.tov_poss_pct
      assert_in_delta 0.140, stat.sf_poss_pct
    end

    def test_efficiency_stats_assignable
      stat = sample_stat

      assert_in_delta 1.20, stat.ppp
      assert_in_delta 95.0, stat.percentile
    end

    private

    def sample_stat
      PlayTypeStat.new(player_id: 201_939, player_name: "Stephen Curry", team_id: Team::GSW,
        team_abbreviation: "GSW", play_type: "Isolation", type_grouping: "offensive", gp: 82,
        poss: 250, poss_pct: 0.085, pts: 300, pts_pct: 0.095, fgm: 100, fga: 200,
        fg_pct: 0.500, efg_pct: 0.575, ft_poss_pct: 0.120, tov_poss_pct: 0.080,
        sf_poss_pct: 0.140, ppp: 1.20, percentile: 95.0)
    end

    def player_info_response
      {resultSets: [{name: "CommonPlayerInfo", headers: %w[PERSON_ID DISPLAY_FIRST_LAST TEAM_ID],
                     rowSet: [[201_939, "Stephen Curry", 1_610_612_744]]}]}
    end
  end
end
