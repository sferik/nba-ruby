require_relative "../test_helper"
require_relative "box_score_matchups_v3_test_helpers"

module NBA
  class BoxScoreMatchupsV3DefensivePlayerTest < Minitest::Test
    include BoxScoreMatchupsV3TestHelpers

    cover BoxScoreMatchupsV3

    def test_find_parses_defensive_person_id
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal 203_507, stat.person_id_def
    end

    def test_find_parses_defensive_first_name
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal "Giannis", stat.first_name_def
    end

    def test_find_parses_defensive_family_name
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal "Antetokounmpo", stat.family_name_def
    end

    def test_find_parses_defensive_name_i_and_slug
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal "G. Antetokounmpo", stat.name_i_def
      assert_equal "giannis-antetokounmpo", stat.player_slug_def
    end

    def test_find_parses_defensive_position_and_comment
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal "F", stat.position_def
      assert_equal "", stat.comment_def
    end

    def test_find_parses_defensive_jersey
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal "34", stat.jersey_num_def
    end

    private

    def stub_matchups_request
      stub_request(:get, /boxscorematchupsv3.*GameID=0022400001/)
        .to_return(body: matchups_v3_response.to_json)
    end
  end
end
