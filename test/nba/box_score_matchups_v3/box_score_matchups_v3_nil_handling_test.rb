require_relative "../../test_helper"
require_relative "box_score_matchups_v3_test_helpers"

module NBA
  class BoxScoreMatchupsV3NilHandlingTest < Minitest::Test
    include BoxScoreMatchupsV3TestHelpers

    cover BoxScoreMatchupsV3

    def test_handles_missing_team_id
      data = offensive_player_data.merge(defensive_player_data, matchup_stats_data)
      stub_response_with_matchup(data)

      assert_nil BoxScoreMatchupsV3.find(game: "0022400001").first.team_id
    end

    def test_handles_missing_team_city_and_name
      data = offensive_player_data.merge(defensive_player_data, matchup_stats_data)
      stub_response_with_matchup(data)

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.team_city
      assert_nil stat.team_name
    end

    def test_handles_missing_team_tricode_and_slug
      data = offensive_player_data.merge(defensive_player_data, matchup_stats_data)
      stub_response_with_matchup(data)

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.team_tricode
      assert_nil stat.team_slug
    end

    def test_handles_missing_offensive_person_id
      data = team_identity_data.merge(defensive_player_data, matchup_stats_data)
      stub_response_with_matchup(data)

      assert_nil BoxScoreMatchupsV3.find(game: "0022400001").first.person_id_off
    end

    def test_handles_missing_offensive_names
      data = team_identity_data.merge(defensive_player_data, matchup_stats_data)
      stub_response_with_matchup(data)

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.first_name_off
      assert_nil stat.family_name_off
      assert_nil stat.name_i_off
    end

    def test_handles_missing_offensive_slug_and_jersey
      data = team_identity_data.merge(defensive_player_data, matchup_stats_data)
      stub_response_with_matchup(data)

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.player_slug_off
      assert_nil stat.jersey_num_off
    end

    def test_handles_missing_defensive_person_id
      data = team_identity_data.merge(offensive_player_data, matchup_stats_data)
      stub_response_with_matchup(data)

      assert_nil BoxScoreMatchupsV3.find(game: "0022400001").first.person_id_def
    end

    def test_handles_missing_defensive_names
      data = team_identity_data.merge(offensive_player_data, matchup_stats_data)
      stub_response_with_matchup(data)

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.first_name_def
      assert_nil stat.family_name_def
      assert_nil stat.name_i_def
    end

    def test_handles_missing_defensive_slug_and_position
      data = team_identity_data.merge(offensive_player_data, matchup_stats_data)
      stub_response_with_matchup(data)

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.player_slug_def
      assert_nil stat.position_def
    end

    def test_handles_missing_defensive_comment_and_jersey
      data = team_identity_data.merge(offensive_player_data, matchup_stats_data)
      stub_response_with_matchup(data)

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_nil stat.comment_def
      assert_nil stat.jersey_num_def
    end

    private

    def stub_response_with_matchup(data)
      response = {boxScoreMatchups: {homeTeam: {players: [data]}, awayTeam: {players: []}}}
      stub_request(:get, /boxscorematchupsv3/).to_return(body: response.to_json)
    end
  end
end
