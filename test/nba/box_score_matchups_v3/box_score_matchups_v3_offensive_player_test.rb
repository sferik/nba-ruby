require_relative "../../test_helper"
require_relative "box_score_matchups_v3_test_helpers"

module NBA
  class BoxScoreMatchupsV3OffensivePlayerTest < Minitest::Test
    include BoxScoreMatchupsV3TestHelpers

    cover BoxScoreMatchupsV3

    def test_find_parses_offensive_person_id
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal 201_939, stat.person_id_off
    end

    def test_find_parses_offensive_first_name
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal "Stephen", stat.first_name_off
    end

    def test_find_parses_offensive_family_name
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal "Curry", stat.family_name_off
    end

    def test_find_parses_offensive_name_i
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal "S. Curry", stat.name_i_off
    end

    def test_find_parses_offensive_player_slug_and_jersey
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal "stephen-curry", stat.player_slug_off
      assert_equal "30", stat.jersey_num_off
    end

    private

    def stub_matchups_request
      stub_request(:get, /boxscorematchupsv3.*GameID=0022400001/)
        .to_return(body: matchups_v3_response.to_json)
    end
  end
end
