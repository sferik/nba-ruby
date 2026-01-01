require_relative "../test_helper"

module NBA
  class LeaderTest < Minitest::Test
    cover Leader

    def test_objects_with_same_player_id_and_category_are_equal
      leader0 = Leader.new(player_id: 201_939, category: "PTS")
      leader1 = Leader.new(player_id: 201_939, category: "PTS")

      assert_equal leader0, leader1
    end

    def test_objects_with_different_category_are_not_equal
      leader0 = Leader.new(player_id: 201_939, category: "PTS")
      leader1 = Leader.new(player_id: 201_939, category: "AST")

      refute_equal leader0, leader1
    end
  end

  class LeaderPlayerHydrationTest < Minitest::Test
    cover Leader

    def test_player_returns_hydrated_player_object
      stub_player_info_request(201_939)
      leader = Leader.new(player_id: 201_939)

      player = leader.player

      assert_instance_of Player, player
      assert_equal 201_939, player.id
    end

    def test_player_calls_api_with_correct_player_id
      stub_player_info_request(201_939)
      leader = Leader.new(player_id: 201_939)

      leader.player

      assert_requested :get, /PlayerID=201939/
    end

    def test_player_returns_nil_when_player_id_is_nil
      leader = Leader.new(player_id: nil)

      assert_nil leader.player
    end

    private

    def stub_player_info_request(player_id)
      response = {resultSets: [{headers: player_info_headers, rowSet: [player_info_row]}]}
      stub_request(:get, /commonplayerinfo.*PlayerID=#{player_id}/).to_return(body: response.to_json)
    end

    def player_info_headers
      %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS JERSEY HEIGHT WEIGHT SCHOOL COUNTRY DRAFT_YEAR DRAFT_ROUND
        DRAFT_NUMBER]
    end

    def player_info_row
      [201_939, "Stephen Curry", "Stephen", "Curry", "Active", "30", "6-2", 185, "Davidson", "USA", 2009, 1, 7]
    end
  end

  class LeaderTeamHydrationTest < Minitest::Test
    cover Leader

    def test_team_returns_team_object
      leader = Leader.new(team_id: Team::GSW)

      team = leader.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
      assert_equal "Golden State Warriors", team.full_name
    end

    def test_team_returns_nil_when_team_id_is_nil
      leader = Leader.new(team_id: nil)

      assert_nil leader.team
    end

    def test_team_returns_nil_for_invalid_team_id
      leader = Leader.new(team_id: 999_999)

      assert_nil leader.team
    end

    def test_team_finds_correct_team_by_id
      leader = Leader.new(team_id: Team::LAL)

      team = leader.team

      assert_equal "Los Angeles Lakers", team.full_name
    end
  end
end
