require_relative "../../test_helper"

module NBA
  class AssistTrackerAllTest < Minitest::Test
    cover AssistTracker

    def test_all_returns_collection
      stub_assist_tracker_request

      assert_instance_of Collection, AssistTracker.all
    end

    def test_all_parses_player_info
      stub_assist_tracker_request

      entry = AssistTracker.all.first

      assert_equal 201_566, entry.player_id
      assert_equal "Russell Westbrook", entry.player_name
      assert_equal Team::LAC, entry.team_id
      assert_equal "LAC", entry.team_abbreviation
    end

    def test_all_parses_pass_info
      stub_assist_tracker_request

      entry = AssistTracker.all.first

      assert_equal "Kawhi Leonard", entry.pass_to
      assert_equal 202_695, entry.pass_to_player_id
      assert_in_delta 0.123, entry.frequency
      assert_equal 45, entry.pass
      assert_equal 32, entry.ast
    end

    def test_all_parses_fg_stats
      stub_assist_tracker_request

      entry = AssistTracker.all.first

      assert_equal 28, entry.fg_m
      assert_equal 45, entry.fg_a
      assert_in_delta 0.622, entry.fg_pct
    end

    def test_all_parses_fg2_stats
      stub_assist_tracker_request

      entry = AssistTracker.all.first

      assert_equal 20, entry.fg2m
      assert_equal 30, entry.fg2a
      assert_in_delta 0.667, entry.fg2_pct
    end

    def test_all_parses_fg3_stats
      stub_assist_tracker_request

      entry = AssistTracker.all.first

      assert_equal 8, entry.fg3m
      assert_equal 15, entry.fg3a
      assert_in_delta 0.533, entry.fg3_pct
    end

    def test_all_with_custom_season
      stub_request(:get, /assisttracker.*Season=2022-23/)
        .to_return(body: assist_tracker_response.to_json)

      AssistTracker.all(season: 2022)

      assert_requested :get, /assisttracker.*Season=2022-23/
    end

    def test_all_with_playoffs_season_type
      stub_request(:get, /assisttracker.*SeasonType=Playoffs/)
        .to_return(body: assist_tracker_response.to_json)

      AssistTracker.all(season_type: "Playoffs")

      assert_requested :get, /assisttracker.*SeasonType=Playoffs/
    end

    def test_all_default_season_type_is_regular_season
      stub_request(:get, /assisttracker.*SeasonType=Regular%20Season/)
        .to_return(body: assist_tracker_response.to_json)

      AssistTracker.all

      assert_requested :get, /assisttracker.*SeasonType=Regular%20Season/
    end

    def test_all_with_per_game_mode
      stub_request(:get, /assisttracker.*PerMode=PerGame/)
        .to_return(body: assist_tracker_response.to_json)

      AssistTracker.all(per_mode: "PerGame")

      assert_requested :get, /assisttracker.*PerMode=PerGame/
    end

    def test_all_default_per_mode_is_totals
      stub_request(:get, /assisttracker.*PerMode=Totals/)
        .to_return(body: assist_tracker_response.to_json)

      AssistTracker.all

      assert_requested :get, /assisttracker.*PerMode=Totals/
    end

    def test_all_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /assisttracker.*LeagueID=00/)
        .to_return(body: assist_tracker_response.to_json)

      AssistTracker.all(league: league)

      assert_requested :get, /assisttracker.*LeagueID=00/
    end

    def test_all_with_league_string
      stub_request(:get, /assisttracker.*LeagueID=00/)
        .to_return(body: assist_tracker_response.to_json)

      AssistTracker.all(league: "00")

      assert_requested :get, /assisttracker.*LeagueID=00/
    end

    private

    def stub_assist_tracker_request
      stub_request(:get, /assisttracker/).to_return(body: assist_tracker_response.to_json)
    end

    def assist_tracker_response
      {resultSets: [{name: "AssistTracker",
                     headers: %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION PASS_TO PASS_TO_PLAYER_ID
                       FREQUENCY PASS AST FGM FGA FG_PCT FG2M FG2A FG2_PCT FG3M FG3A FG3_PCT],
                     rowSet: [[201_566, "Russell Westbrook", Team::LAC, "LAC", "Kawhi Leonard", 202_695,
                       0.123, 45, 32, 28, 45, 0.622, 20, 30, 0.667, 8, 15, 0.533]]}]}
    end
  end
end
