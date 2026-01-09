require_relative "../test_helper"

module NBA
  class VideoDetailTest < Minitest::Test
    cover VideoDetail

    def test_objects_with_same_video_id_are_equal
      video0 = VideoDetail.new(video_id: "abc123")
      video1 = VideoDetail.new(video_id: "abc123")

      assert_equal video0, video1
    end

    def test_objects_with_different_video_id_are_not_equal
      video0 = VideoDetail.new(video_id: "abc123")
      video1 = VideoDetail.new(video_id: "def456")

      refute_equal video0, video1
    end

    def test_available_returns_true_when_video_available_is_one
      video = VideoDetail.new(video_available: 1)

      assert_predicate video, :available?
    end

    def test_available_returns_false_when_video_available_is_zero
      video = VideoDetail.new(video_available: 0)

      refute_predicate video, :available?
    end

    def test_player_returns_player_object
      stub_player_info_request(201_939)
      video = VideoDetail.new(player_id: 201_939)

      player = video.player

      assert_instance_of Player, player
      assert_equal 201_939, player.id
    end

    def test_player_returns_nil_when_player_id_is_nil
      video = VideoDetail.new(player_id: nil)

      assert_nil video.player
    end

    def test_team_returns_team_object
      video = VideoDetail.new(team_id: Team::GSW)

      team = video.team

      assert_instance_of Team, team
      assert_equal Team::GSW, team.id
    end

    def test_team_returns_nil_when_team_id_is_nil
      video = VideoDetail.new(team_id: nil)

      assert_nil video.team
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
end
