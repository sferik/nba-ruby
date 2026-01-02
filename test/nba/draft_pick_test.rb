require_relative "../test_helper"

module NBA
  class DraftPickTest < Minitest::Test
    cover DraftPick

    def test_objects_with_same_player_id_and_season_are_equal
      pick0 = DraftPick.new(player_id: 123, season: 2023)
      pick1 = DraftPick.new(player_id: 123, season: 2023)

      assert_equal pick0, pick1
    end

    def test_objects_with_different_season_are_not_equal
      pick0 = DraftPick.new(player_id: 123, season: 2023)
      pick1 = DraftPick.new(player_id: 123, season: 2022)

      refute_equal pick0, pick1
    end

    def test_player_returns_player_object
      stub_request(:get, %r{stats\.nba\.com/stats/commonplayerinfo}).to_return(body: player_info_response.to_json)
      pick = DraftPick.new(player_id: 201_939)

      player = pick.player

      assert_instance_of Player, player
      assert_equal 201_939, player.id
    end

    def test_player_returns_nil_when_player_id_is_nil
      pick = DraftPick.new(player_id: nil)

      assert_nil pick.player
    end

    def test_team_returns_team_object
      pick = DraftPick.new(team_id: Team::GSW)

      team = pick.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_team_returns_nil_when_team_id_is_nil
      pick = DraftPick.new(team_id: nil)

      assert_nil pick.team
    end

    private

    def player_info_response
      headers = %w[PERSON_ID DISPLAY_FIRST_LAST FIRST_NAME LAST_NAME ROSTERSTATUS JERSEY HEIGHT
        WEIGHT SCHOOL COUNTRY DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER]
      row = [201_939, "Stephen Curry", "Stephen", "Curry", "Active", "30", "6-2", 185, "Davidson", "USA", 2009, 1, 7]
      {resultSets: [{headers: headers, rowSet: [row]}]}
    end
  end
end
