require_relative "../../test_helper"

module NBA
  class TeamVsPlayerParamsTest < Minitest::Test
    cover TeamVsPlayer

    def test_includes_team_id_in_path
      request = stub_request(:get, /teamvsplayer.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566)

      assert_requested request
    end

    def test_includes_vs_player_id_in_path
      request = stub_request(:get, /teamvsplayer.*VsPlayerID=201566/).to_return(body: empty_response.to_json)
      TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566)

      assert_requested request
    end

    def test_extracts_id_from_team_object
      team = Minitest::Mock.new
      team.expect :id, 1_610_612_744
      request = stub_request(:get, /teamvsplayer.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      TeamVsPlayer.overall(team: team, vs_player: 201_566)

      assert_requested request
      team.verify
    end

    def test_extracts_id_from_vs_player_object
      vs_player = Minitest::Mock.new
      vs_player.expect :id, 201_566
      request = stub_request(:get, /teamvsplayer.*VsPlayerID=201566/).to_return(body: empty_response.to_json)
      TeamVsPlayer.overall(team: 1_610_612_744, vs_player: vs_player)

      assert_requested request
      vs_player.verify
    end

    def test_includes_season_in_path
      request = stub_request(:get, /teamvsplayer.*Season=2023-24/).to_return(body: empty_response.to_json)
      TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566, season: 2023)

      assert_requested request
    end

    def test_includes_season_type_in_path
      request = stub_request(:get, /teamvsplayer.*SeasonType=Playoffs/).to_return(body: empty_response.to_json)
      TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566, season_type: "Playoffs")

      assert_requested request
    end

    def test_includes_per_mode_in_path
      request = stub_request(:get, /teamvsplayer.*PerMode=Totals/).to_return(body: empty_response.to_json)
      TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566, per_mode: "Totals")

      assert_requested request
    end

    def test_includes_league_id_in_path
      request = stub_request(:get, /teamvsplayer.*LeagueID=00/).to_return(body: empty_response.to_json)
      TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566)

      assert_requested request
    end

    def test_default_season_type_is_regular_season
      request = stub_request(:get, /teamvsplayer.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566)

      assert_requested request
    end

    def test_default_per_mode_is_per_game
      request = stub_request(:get, /teamvsplayer.*PerMode=PerGame/).to_return(body: empty_response.to_json)
      TeamVsPlayer.overall(team: 1_610_612_744, vs_player: 201_566)

      assert_requested request
    end

    private

    def empty_response
      {resultSets: [{name: "Overall", headers: [], rowSet: []}]}
    end
  end
end
