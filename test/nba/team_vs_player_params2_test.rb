require_relative "../test_helper"

module NBA
  class TeamVsPlayerParams2Test < Minitest::Test
    cover TeamVsPlayer

    def test_on_off_court_includes_team_id_in_path
      request = stub_request(:get, /teamvsplayer.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      TeamVsPlayer.on_off_court(team: 1_610_612_744, vs_player: 201_566)

      assert_requested request
    end

    def test_on_off_court_extracts_id_from_team_object
      team = Minitest::Mock.new
      team.expect :id, 1_610_612_744
      request = stub_request(:get, /teamvsplayer.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      TeamVsPlayer.on_off_court(team: team, vs_player: 201_566)

      assert_requested request
      team.verify
    end

    def test_on_off_court_extracts_id_from_vs_player_object
      vs_player = Minitest::Mock.new
      vs_player.expect :id, 201_566
      request = stub_request(:get, /teamvsplayer.*VsPlayerID=201566/).to_return(body: empty_response.to_json)
      TeamVsPlayer.on_off_court(team: 1_610_612_744, vs_player: vs_player)

      assert_requested request
      vs_player.verify
    end

    def test_on_off_court_default_season_type_is_regular_season
      request = stub_request(:get, /teamvsplayer.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      TeamVsPlayer.on_off_court(team: 1_610_612_744, vs_player: 201_566)

      assert_requested request
    end

    def test_on_off_court_default_per_mode_is_per_game
      request = stub_request(:get, /teamvsplayer.*PerMode=PerGame/).to_return(body: empty_response.to_json)
      TeamVsPlayer.on_off_court(team: 1_610_612_744, vs_player: 201_566)

      assert_requested request
    end

    private

    def empty_response
      {resultSets: [{name: "OnOffCourt", headers: [], rowSet: []}]}
    end
  end
end
