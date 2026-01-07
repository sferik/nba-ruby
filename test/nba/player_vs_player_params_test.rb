require_relative "../test_helper"

module NBA
  class PlayerVsPlayerParamsTest < Minitest::Test
    cover PlayerVsPlayer

    def test_includes_player_id_in_path
      request = stub_request(:get, /playervsplayer.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerVsPlayer.overall(player: 201_939, vs_player: 201_566)

      assert_requested request
    end

    def test_includes_vs_player_id_in_path
      request = stub_request(:get, /playervsplayer.*VsPlayerID=201566/).to_return(body: empty_response.to_json)
      PlayerVsPlayer.overall(player: 201_939, vs_player: 201_566)

      assert_requested request
    end

    def test_extracts_id_from_player_object
      player = Minitest::Mock.new
      player.expect :id, 201_939
      request = stub_request(:get, /playervsplayer.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerVsPlayer.overall(player: player, vs_player: 201_566)

      assert_requested request
      player.verify
    end

    def test_extracts_id_from_vs_player_object
      vs_player = Minitest::Mock.new
      vs_player.expect :id, 201_566
      request = stub_request(:get, /playervsplayer.*VsPlayerID=201566/).to_return(body: empty_response.to_json)
      PlayerVsPlayer.overall(player: 201_939, vs_player: vs_player)

      assert_requested request
      vs_player.verify
    end

    def test_includes_season_in_path
      request = stub_request(:get, /playervsplayer.*Season=2023-24/).to_return(body: empty_response.to_json)
      PlayerVsPlayer.overall(player: 201_939, vs_player: 201_566, season: 2023)

      assert_requested request
    end

    def test_includes_season_type_in_path
      request = stub_request(:get, /playervsplayer.*SeasonType=Playoffs/).to_return(body: empty_response.to_json)
      PlayerVsPlayer.overall(player: 201_939, vs_player: 201_566, season_type: "Playoffs")

      assert_requested request
    end

    def test_includes_per_mode_in_path
      request = stub_request(:get, /playervsplayer.*PerMode=Totals/).to_return(body: empty_response.to_json)
      PlayerVsPlayer.overall(player: 201_939, vs_player: 201_566, per_mode: "Totals")

      assert_requested request
    end

    def test_includes_league_id_in_path
      request = stub_request(:get, /playervsplayer.*LeagueID=00/).to_return(body: empty_response.to_json)
      PlayerVsPlayer.overall(player: 201_939, vs_player: 201_566)

      assert_requested request
    end

    def test_default_season_type_is_regular_season
      request = stub_request(:get, /playervsplayer.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      PlayerVsPlayer.overall(player: 201_939, vs_player: 201_566)

      assert_requested request
    end

    def test_default_per_mode_is_per_game
      request = stub_request(:get, /playervsplayer.*PerMode=PerGame/).to_return(body: empty_response.to_json)
      PlayerVsPlayer.overall(player: 201_939, vs_player: 201_566)

      assert_requested request
    end

    def test_on_off_court_includes_player_id_in_path
      request = stub_request(:get, /playervsplayer.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerVsPlayer.on_off_court(player: 201_939, vs_player: 201_566)

      assert_requested request
    end

    def test_on_off_court_extracts_id_from_player_object
      player = Minitest::Mock.new
      player.expect :id, 201_939
      request = stub_request(:get, /playervsplayer.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerVsPlayer.on_off_court(player: player, vs_player: 201_566)

      assert_requested request
      player.verify
    end

    def test_on_off_court_extracts_id_from_vs_player_object
      vs_player = Minitest::Mock.new
      vs_player.expect :id, 201_566
      request = stub_request(:get, /playervsplayer.*VsPlayerID=201566/).to_return(body: empty_response.to_json)
      PlayerVsPlayer.on_off_court(player: 201_939, vs_player: vs_player)

      assert_requested request
      vs_player.verify
    end

    def test_on_off_court_default_season_type_is_regular_season
      request = stub_request(:get, /playervsplayer.*SeasonType=Regular%20Season/)
        .to_return(body: empty_response.to_json)
      PlayerVsPlayer.on_off_court(player: 201_939, vs_player: 201_566)

      assert_requested request
    end

    def test_on_off_court_default_per_mode_is_per_game
      request = stub_request(:get, /playervsplayer.*PerMode=PerGame/).to_return(body: empty_response.to_json)
      PlayerVsPlayer.on_off_court(player: 201_939, vs_player: 201_566)

      assert_requested request
    end

    private

    def empty_response
      {resultSets: [{name: "Overall", headers: [], rowSet: []}]}
    end
  end
end
