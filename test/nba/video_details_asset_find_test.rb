require_relative "../test_helper"

module NBA
  class VideoDetailsAssetFindTest < Minitest::Test
    cover VideoDetailsAsset

    def test_find_returns_collection
      stub_video_details_asset_request

      assert_instance_of Collection, VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023)
    end

    def test_find_uses_player_parameter
      stub_video_details_asset_request

      VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023)

      assert_requested :get, /videodetailsasset.*PlayerID=201939/
    end

    def test_find_uses_team_parameter
      stub_video_details_asset_request

      VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023)

      assert_requested :get, /videodetailsasset.*TeamID=#{Team::GSW}/o
    end

    def test_find_uses_season_parameter
      stub_video_details_asset_request

      VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023)

      assert_requested :get, /videodetailsasset.*Season=2023-24/
    end

    def test_find_uses_default_context_measure
      stub_video_details_asset_request

      VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023)

      assert_requested :get, /videodetailsasset.*ContextMeasure=FGA/
    end

    def test_find_accepts_custom_context_measure
      stub_video_details_asset_request

      VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023, context_measure: "PTS")

      assert_requested :get, /videodetailsasset.*ContextMeasure=PTS/
    end

    def test_find_uses_default_season_type
      stub_video_details_asset_request

      VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023)

      assert_requested :get, /videodetailsasset.*SeasonType=Regular(%20|\+)Season/
    end

    def test_find_accepts_custom_season_type
      stub_video_details_asset_request

      VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023, season_type: "Playoffs")

      assert_requested :get, /videodetailsasset.*SeasonType=Playoffs/
    end

    def test_find_uses_default_league_id
      stub_video_details_asset_request

      VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023)

      assert_requested :get, /videodetailsasset.*LeagueID=00/
    end

    def test_find_accepts_custom_league
      stub_video_details_asset_request

      VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023, league: "10")

      assert_requested :get, /videodetailsasset.*LeagueID=10/
    end

    def test_find_accepts_league_object
      stub_video_details_asset_request
      league = League.new(id: "10", name: "WNBA")

      VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023, league: league)

      assert_requested :get, /videodetailsasset.*LeagueID=10/
    end

    def test_find_uses_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, video_details_asset_response.to_json, [String]

      result = VideoDetailsAsset.find(player: 201_939, team: Team::GSW, season: 2023, client: mock_client)

      assert_instance_of Collection, result
      mock_client.verify
    end

    def test_find_accepts_player_object
      stub_video_details_asset_request
      player = Player.new(id: 201_939)

      VideoDetailsAsset.find(player: player, team: Team::GSW, season: 2023)

      assert_requested :get, /videodetailsasset.*PlayerID=201939/
    end

    def test_find_accepts_team_object
      stub_video_details_asset_request
      team = Team.new(id: Team::GSW)

      VideoDetailsAsset.find(player: 201_939, team: team, season: 2023)

      assert_requested :get, /videodetailsasset.*TeamID=#{Team::GSW}/o
    end

    private

    def stub_video_details_asset_request
      stub_request(:get, /videodetailsasset/).to_return(body: video_details_asset_response.to_json)
    end

    def video_details_asset_response
      {resultSets: [
        {name: "VideoDetailsAsset", headers: video_details_asset_headers, rowSet: [video_details_asset_row]}
      ]}
    end

    def video_details_asset_headers
      %w[UUID GAME_ID GAME_EVENT_ID VIDEO_AVAILABLE VIDEO_URL FILE_SIZE ASPECT_RATIO VIDEO_DURATION
        VIDEO_DESCRIPTION]
    end

    def video_details_asset_row
      ["abc123def456", "0022300001", 1, 1, "https://videos.nba.com/video.mp4", 1_024_000, "16:9", 12.5,
        "3PT Jump Shot"]
    end
  end
end
