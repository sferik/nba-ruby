require_relative "../test_helper"
require_relative "box_score_matchups_v3_test_helpers"

module NBA
  class BoxScoreMatchupsV3BasicTest < Minitest::Test
    include BoxScoreMatchupsV3TestHelpers

    cover BoxScoreMatchupsV3

    def test_find_returns_collection
      stub_matchups_request

      assert_instance_of Collection, BoxScoreMatchupsV3.find(game: "0022400001")
    end

    def test_find_uses_correct_game_id_in_path
      stub_matchups_request

      BoxScoreMatchupsV3.find(game: "0022400001")

      assert_requested :get, /boxscorematchupsv3.*GameID=0022400001/
    end

    def test_find_parses_game_id
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
    end

    def test_find_parses_team_id_and_city
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal Team::GSW, stat.team_id
      assert_equal "Golden State", stat.team_city
    end

    def test_find_parses_team_name_and_tricode
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal "Warriors", stat.team_name
      assert_equal "GSW", stat.team_tricode
    end

    def test_find_parses_team_slug
      stub_matchups_request

      stat = BoxScoreMatchupsV3.find(game: "0022400001").first

      assert_equal "warriors", stat.team_slug
    end

    private

    def stub_matchups_request
      stub_request(:get, /boxscorematchupsv3.*GameID=0022400001/)
        .to_return(body: matchups_v3_response.to_json)
    end
  end
end
