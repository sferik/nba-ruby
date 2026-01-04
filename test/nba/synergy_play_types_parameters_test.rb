require_relative "synergy_play_types_test_helper"

module NBA
  class SynergyPlayTypesParametersTest < Minitest::Test
    include SynergyPlayTypesTestHelper

    cover SynergyPlayTypes

    # Test that parameters are actually used in player_stats
    def test_player_stats_uses_play_type_parameter
      stub_request(:get, /PlayType=Transition/)
        .to_return(body: player_play_type_response("Transition", "offensive").to_json)

      stats = SynergyPlayTypes.player_stats(play_type: "Transition")

      assert_requested :get, /PlayType=Transition/
      assert_equal "Transition", stats.first.play_type
    end

    def test_player_stats_uses_type_grouping_parameter
      stub_request(:get, /TypeGrouping=defensive/)
        .to_return(body: player_play_type_response("Isolation", "defensive").to_json)

      stats = SynergyPlayTypes.player_stats(play_type: "Isolation", type_grouping: "defensive")

      assert_requested :get, /TypeGrouping=defensive/
      assert_equal "defensive", stats.first.type_grouping
    end

    def test_player_stats_uses_season_parameter
      stub_request(:get, /SeasonYear=2022-23/)
        .to_return(body: player_play_type_response("Isolation", "offensive").to_json)

      SynergyPlayTypes.player_stats(play_type: "Isolation", season: 2022)

      assert_requested :get, /SeasonYear=2022-23/
    end

    def test_player_stats_uses_season_type_parameter
      stub_request(:get, /SeasonType=Playoffs/)
        .to_return(body: player_play_type_response("Isolation", "offensive").to_json)

      SynergyPlayTypes.player_stats(play_type: "Isolation", season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_player_stats_uses_per_mode_parameter
      stub_request(:get, /PerMode=Totals/)
        .to_return(body: player_play_type_response("Isolation", "offensive").to_json)

      SynergyPlayTypes.player_stats(play_type: "Isolation", per_mode: "Totals")

      assert_requested :get, /PerMode=Totals/
    end

    # Test that parameters are actually used in team_stats
    def test_team_stats_uses_play_type_parameter
      stub_request(:get, /PlayType=Postup/)
        .to_return(body: team_play_type_response("Postup", "offensive").to_json)

      stats = SynergyPlayTypes.team_stats(play_type: "Postup")

      assert_requested :get, /PlayType=Postup/
      assert_equal "Postup", stats.first.play_type
    end

    def test_team_stats_uses_type_grouping_parameter
      stub_request(:get, /TypeGrouping=defensive/)
        .to_return(body: team_play_type_response("Transition", "defensive").to_json)

      stats = SynergyPlayTypes.team_stats(play_type: "Transition", type_grouping: "defensive")

      assert_requested :get, /TypeGrouping=defensive/
      assert_equal "defensive", stats.first.type_grouping
    end

    def test_team_stats_uses_season_parameter
      stub_request(:get, /SeasonYear=2021-22/)
        .to_return(body: team_play_type_response("Transition", "offensive").to_json)

      SynergyPlayTypes.team_stats(play_type: "Transition", season: 2021)

      assert_requested :get, /SeasonYear=2021-22/
    end

    def test_team_stats_uses_season_type_parameter
      stub_request(:get, /SeasonType=Playoffs/)
        .to_return(body: team_play_type_response("Transition", "offensive").to_json)

      SynergyPlayTypes.team_stats(play_type: "Transition", season_type: "Playoffs")

      assert_requested :get, /SeasonType=Playoffs/
    end

    def test_team_stats_uses_per_mode_parameter
      stub_request(:get, /PerMode=Totals/)
        .to_return(body: team_play_type_response("Transition", "offensive").to_json)

      SynergyPlayTypes.team_stats(play_type: "Transition", per_mode: "Totals")

      assert_requested :get, /PerMode=Totals/
    end

    # Test that response is passed to parse_response
    def test_player_stats_parses_returned_response
      response_body = player_play_type_response("Isolation", "offensive").to_json
      stub_request(:get, /synergyplaytypes/).to_return(body: response_body)

      stats = SynergyPlayTypes.player_stats(play_type: "Isolation")

      assert_equal 1, stats.size
      assert_equal "Stephen Curry", stats.first.player_name
    end

    def test_team_stats_parses_returned_response
      response_body = team_play_type_response("Transition", "offensive").to_json
      stub_request(:get, /synergyplaytypes/).to_return(body: response_body)

      stats = SynergyPlayTypes.team_stats(play_type: "Transition")

      assert_equal 1, stats.size
      assert_equal "GSW", stats.first.team_abbreviation
    end
  end
end
