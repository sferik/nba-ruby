require_relative "synergy_play_types_test_helper"

module NBA
  class SynergyPlayTypesTeamTest < Minitest::Test
    include SynergyPlayTypesTestHelper

    cover SynergyPlayTypes

    def test_team_stats_returns_collection
      stub_team_play_type_request

      assert_instance_of Collection, SynergyPlayTypes.team_stats(play_type: "Transition")
    end

    def test_team_stats_parses_data
      stub_team_play_type_request

      stat = SynergyPlayTypes.team_stats(play_type: "Transition").first

      assert_equal Team::GSW, stat.team_id
      assert_equal "GSW", stat.team_abbreviation
      assert_equal "Transition", stat.play_type
    end

    def test_team_stats_defaults_to_offensive
      stub_request(:get, /TypeGrouping=offensive/)
        .to_return(body: team_play_type_response("Transition", "offensive").to_json)

      stat = SynergyPlayTypes.team_stats(play_type: "Transition").first

      assert_equal "offensive", stat.type_grouping
    end

    def test_team_stats_defaults_to_current_season
      current_season_str = Utils.format_season(Utils.current_season)
      stub_request(:get, /SeasonYear=#{Regexp.escape(current_season_str)}/)
        .to_return(body: team_play_type_response("Transition", "offensive").to_json)

      SynergyPlayTypes.team_stats(play_type: "Transition")

      assert_requested :get, /SeasonYear=#{Regexp.escape(current_season_str)}/
    end

    def test_team_stats_defaults_to_regular_season
      stub_request(:get, /SeasonType=Regular(%20|\+)Season/)
        .to_return(body: team_play_type_response("Transition", "offensive").to_json)

      SynergyPlayTypes.team_stats(play_type: "Transition")

      assert_requested :get, /SeasonType=Regular(%20|\+)Season/
    end

    def test_team_stats_defaults_to_per_game
      stub_request(:get, /PerMode=PerGame/)
        .to_return(body: team_play_type_response("Transition", "offensive").to_json)

      SynergyPlayTypes.team_stats(play_type: "Transition")

      assert_requested :get, /PerMode=PerGame/
    end
  end
end
