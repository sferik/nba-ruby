require_relative "synergy_play_types_test_helper"

module NBA
  class SynergyPlayTypesPlayerTest < Minitest::Test
    include SynergyPlayTypesTestHelper

    cover SynergyPlayTypes

    def test_player_stats_returns_collection
      stub_player_play_type_request

      assert_instance_of Collection, SynergyPlayTypes.player_stats(play_type: "Isolation")
    end

    def test_player_stats_parses_player_identity
      stub_player_play_type_request

      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_equal 201_939, stat.player_id
      assert_equal "Stephen Curry", stat.player_name
      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
    end

    def test_player_stats_parses_play_type_info
      stub_player_play_type_request

      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_equal "Isolation", stat.play_type
      assert_equal "offensive", stat.type_grouping
      assert_equal 82, stat.gp
    end

    def test_player_stats_parses_possession_attributes
      stub_player_play_type_request

      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_equal 250, stat.poss
      assert_in_delta 0.085, stat.poss_pct
      assert_equal 300, stat.pts
      assert_in_delta 0.095, stat.pts_pct
    end

    def test_player_stats_parses_shooting_stats
      stub_player_play_type_request

      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_equal 100, stat.fgm
      assert_equal 200, stat.fga
      assert_in_delta 0.500, stat.fg_pct
      assert_in_delta 0.575, stat.efg_pct
    end

    def test_player_stats_parses_possession_efficiency
      stub_player_play_type_request

      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_in_delta 0.120, stat.ft_poss_pct
      assert_in_delta 0.080, stat.tov_poss_pct
      assert_in_delta 0.140, stat.sf_poss_pct
      assert_in_delta 1.20, stat.ppp
      assert_in_delta 95.0, stat.percentile
    end

    def test_player_stats_with_type_grouping
      stub_request(:get, /synergyplaytypes.*TypeGrouping=defensive/)
        .to_return(body: player_play_type_response("Isolation", "defensive").to_json)

      SynergyPlayTypes.player_stats(play_type: "Isolation", type_grouping: SynergyPlayTypes::DEFENSIVE)

      assert_requested :get, /synergyplaytypes.*TypeGrouping=defensive/
    end

    def test_player_stats_with_season_param
      stub_request(:get, /synergyplaytypes.*SeasonYear=2023-24/)
        .to_return(body: player_play_type_response("Isolation", "offensive").to_json)

      SynergyPlayTypes.player_stats(play_type: "Isolation", season: 2023)

      assert_requested :get, /synergyplaytypes.*SeasonYear=2023-24/
    end

    def test_player_stats_with_season_type_param
      stub_request(:get, /synergyplaytypes.*SeasonType=Playoffs/)
        .to_return(body: player_play_type_response("Isolation", "offensive").to_json)

      SynergyPlayTypes.player_stats(play_type: "Isolation", season_type: SynergyPlayTypes::PLAYOFFS)

      assert_requested :get, /synergyplaytypes.*SeasonType=Playoffs/
    end

    def test_player_stats_with_per_mode_param
      stub_request(:get, /synergyplaytypes.*PerMode=Totals/)
        .to_return(body: player_play_type_response("Isolation", "offensive").to_json)

      SynergyPlayTypes.player_stats(play_type: "Isolation", per_mode: SynergyPlayTypes::TOTALS)

      assert_requested :get, /synergyplaytypes.*PerMode=Totals/
    end

    def test_player_stats_defaults_to_offensive
      stub_player_play_type_request

      stat = SynergyPlayTypes.player_stats(play_type: "Isolation").first

      assert_equal "offensive", stat.type_grouping
    end

    def test_player_stats_defaults_to_current_season
      current_season_str = Utils.format_season(Utils.current_season)
      stub_request(:get, /SeasonYear=#{Regexp.escape(current_season_str)}/)
        .to_return(body: player_play_type_response("Isolation", "offensive").to_json)

      SynergyPlayTypes.player_stats(play_type: "Isolation")

      assert_requested :get, /SeasonYear=#{Regexp.escape(current_season_str)}/
    end

    def test_player_stats_defaults_to_regular_season
      stub_request(:get, /SeasonType=Regular(%20|\+)Season/)
        .to_return(body: player_play_type_response("Isolation", "offensive").to_json)

      SynergyPlayTypes.player_stats(play_type: "Isolation")

      assert_requested :get, /SeasonType=Regular(%20|\+)Season/
    end

    def test_player_stats_defaults_to_per_game
      stub_request(:get, /PerMode=PerGame/)
        .to_return(body: player_play_type_response("Isolation", "offensive").to_json)

      SynergyPlayTypes.player_stats(play_type: "Isolation")

      assert_requested :get, /PerMode=PerGame/
    end
  end
end
