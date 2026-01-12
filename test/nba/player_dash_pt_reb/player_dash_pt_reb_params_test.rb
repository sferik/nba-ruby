require_relative "../../test_helper"

module NBA
  class PlayerDashPtRebParamsTest < Minitest::Test
    cover PlayerDashPtReb

    def test_overall_uses_correct_result_set
      stub_request(:get, /playerdashptreb/).to_return(body: response_with_all_result_sets.to_json)

      assert_equal "Overall", PlayerDashPtReb.overall(player: 201_939).first.overall
    end

    def test_num_contested_uses_correct_result_set
      stub_request(:get, /playerdashptreb/).to_return(body: response_with_all_result_sets.to_json)

      assert_equal "0 Contests", PlayerDashPtReb.num_contested(player: 201_939).first.reb_num_contesting_range
    end

    def test_reb_distance_uses_correct_result_set
      stub_request(:get, /playerdashptreb/).to_return(body: response_with_all_result_sets.to_json)

      assert_equal "0-6 Feet", PlayerDashPtReb.reb_distance(player: 201_939).first.reb_dist_range
    end

    def test_shot_distance_uses_correct_result_set
      stub_request(:get, /playerdashptreb/).to_return(body: response_with_all_result_sets.to_json)

      assert_equal "0-6 Feet", PlayerDashPtReb.shot_distance(player: 201_939).first.shot_dist_range
    end

    def test_shot_type_uses_correct_result_set
      stub_request(:get, /playerdashptreb/).to_return(body: response_with_all_result_sets.to_json)

      assert_equal "2PT FGs", PlayerDashPtReb.shot_type(player: 201_939).first.shot_type_range
    end

    def test_includes_player_id_in_path
      request = stub_request(:get, /playerdashptreb.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtReb.overall(player: 201_939)

      assert_requested request
    end

    def test_extracts_id_from_player_object
      player = Minitest::Mock.new
      player.expect :id, 201_939
      request = stub_request(:get, /playerdashptreb.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtReb.overall(player: player)

      assert_requested request
      player.verify
    end

    def test_extracts_id_from_team_object
      team = Minitest::Mock.new
      team.expect :id, 1_610_612_744
      request = stub_request(:get, /playerdashptreb.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      PlayerDashPtReb.overall(player: 201_939, team: team)

      assert_requested request
      team.verify
    end

    def test_includes_team_id_in_path
      request = stub_request(:get, /playerdashptreb.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      PlayerDashPtReb.overall(player: 201_939, team: 1_610_612_744)

      assert_requested request
    end

    def test_includes_season_in_path
      request = stub_request(:get, /playerdashptreb.*Season=2023-24/).to_return(body: empty_response.to_json)
      PlayerDashPtReb.overall(player: 201_939, season: 2023)

      assert_requested request
    end

    def test_includes_season_type_in_path
      request = stub_request(:get, /playerdashptreb.*SeasonType=Playoffs/).to_return(body: empty_response.to_json)
      PlayerDashPtReb.overall(player: 201_939, season_type: "Playoffs")

      assert_requested request
    end

    def test_includes_per_mode_in_path
      request = stub_request(:get, /playerdashptreb.*PerMode=Totals/).to_return(body: empty_response.to_json)
      PlayerDashPtReb.overall(player: 201_939, per_mode: "Totals")

      assert_requested request
    end

    def test_includes_league_id_in_path
      request = stub_request(:get, /playerdashptreb.*LeagueID=00/).to_return(body: empty_response.to_json)
      PlayerDashPtReb.overall(player: 201_939)

      assert_requested request
    end

    private

    def response_with_all_result_sets
      {resultSets: [
        {name: "OverallRebounding", headers: %w[G OVERALL], rowSet: [[74, "Overall"]]},
        {name: "NumContestedRebounding", headers: %w[G REB_NUM_CONTESTING_RANGE], rowSet: [[74, "0 Contests"]]},
        {name: "RebDistanceRebounding", headers: %w[G REB_DIST_RANGE], rowSet: [[74, "0-6 Feet"]]},
        {name: "ShotDistanceRebounding", headers: %w[G SHOT_DIST_RANGE], rowSet: [[74, "0-6 Feet"]]},
        {name: "ShotTypeRebounding", headers: %w[G SHOT_TYPE_RANGE], rowSet: [[74, "2PT FGs"]]}
      ]}
    end

    def empty_response
      {resultSets: [{name: "OverallRebounding", headers: [], rowSet: []}]}
    end
  end
end
