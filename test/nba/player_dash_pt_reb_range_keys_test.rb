require_relative "../test_helper"

module NBA
  class PlayerDashPtRebRangeKeysTest < Minitest::Test
    cover PlayerDashPtReb

    def test_handles_missing_overall_key
      assert_nil overall_stat_without_key("OVERALL").overall
    end

    def test_handles_missing_reb_dist_range_key
      assert_nil reb_distance_stat_without_key("REB_DIST_RANGE").reb_dist_range
    end

    def test_handles_missing_shot_dist_range_key
      assert_nil shot_distance_stat_without_key("SHOT_DIST_RANGE").shot_dist_range
    end

    def test_handles_missing_shot_type_range_key
      assert_nil shot_type_stat_without_key("SHOT_TYPE_RANGE").shot_type_range
    end

    private

    def overall_stat_without_key(key)
      headers = overall_headers.reject { |h| h.eql?(key) }
      row = overall_values.except(*key).values
      response = {resultSets: [{name: "OverallRebounding", headers: headers, rowSet: [row]}]}
      stub_request(:get, /playerdashptreb/).to_return(body: response.to_json)
      PlayerDashPtReb.overall(player: 201_939).first
    end

    def reb_distance_stat_without_key(key)
      headers = reb_distance_headers.reject { |h| h.eql?(key) }
      row = reb_distance_values.except(*key).values
      response = {resultSets: [{name: "RebDistanceRebounding", headers: headers, rowSet: [row]}]}
      stub_request(:get, /playerdashptreb/).to_return(body: response.to_json)
      PlayerDashPtReb.reb_distance(player: 201_939).first
    end

    def shot_distance_stat_without_key(key)
      headers = shot_distance_headers.reject { |h| h.eql?(key) }
      row = shot_distance_values.except(*key).values
      response = {resultSets: [{name: "ShotDistanceRebounding", headers: headers, rowSet: [row]}]}
      stub_request(:get, /playerdashptreb/).to_return(body: response.to_json)
      PlayerDashPtReb.shot_distance(player: 201_939).first
    end

    def shot_type_stat_without_key(key)
      headers = shot_type_headers.reject { |h| h.eql?(key) }
      row = shot_type_values.except(*key).values
      response = {resultSets: [{name: "ShotTypeRebounding", headers: headers, rowSet: [row]}]}
      stub_request(:get, /playerdashptreb/).to_return(body: response.to_json)
      PlayerDashPtReb.shot_type(player: 201_939).first
    end

    def overall_headers
      %w[PLAYER_ID PLAYER_NAME_LAST_FIRST G OVERALL REB_FREQUENCY]
    end

    def reb_distance_headers
      %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER G REB_DIST_RANGE REB_FREQUENCY]
    end

    def shot_distance_headers
      %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER G SHOT_DIST_RANGE REB_FREQUENCY]
    end

    def shot_type_headers
      %w[PLAYER_ID PLAYER_NAME_LAST_FIRST SORT_ORDER G SHOT_TYPE_RANGE REB_FREQUENCY]
    end

    def overall_values
      {"PLAYER_ID" => 201_939, "PLAYER_NAME_LAST_FIRST" => "Curry", "G" => 74, "OVERALL" => "Overall",
       "REB_FREQUENCY" => 0.25}
    end

    def reb_distance_values
      {"PLAYER_ID" => 201_939, "PLAYER_NAME_LAST_FIRST" => "Curry", "SORT_ORDER" => 1, "G" => 74,
       "REB_DIST_RANGE" => "0-6 Feet", "REB_FREQUENCY" => 0.25}
    end

    def shot_distance_values
      {"PLAYER_ID" => 201_939, "PLAYER_NAME_LAST_FIRST" => "Curry", "SORT_ORDER" => 1, "G" => 74,
       "SHOT_DIST_RANGE" => "0-6 Feet", "REB_FREQUENCY" => 0.25}
    end

    def shot_type_values
      {"PLAYER_ID" => 201_939, "PLAYER_NAME_LAST_FIRST" => "Curry", "SORT_ORDER" => 1, "G" => 74,
       "SHOT_TYPE_RANGE" => "2PT FGs", "REB_FREQUENCY" => 0.25}
    end
  end
end
