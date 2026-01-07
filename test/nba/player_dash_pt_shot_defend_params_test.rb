require_relative "../test_helper"

module NBA
  class PlayerDashPtShotDefendParamsTest < Minitest::Test
    cover PlayerDashPtShotDefend

    def test_includes_player_id_in_path
      request = stub_request(:get, /playerdashptshotdefend.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtShotDefend.find(player: 201_939)

      assert_requested request
    end

    def test_extracts_id_from_player_object
      player = Minitest::Mock.new
      player.expect :id, 201_939
      request = stub_request(:get, /playerdashptshotdefend.*PlayerID=201939/).to_return(body: empty_response.to_json)
      PlayerDashPtShotDefend.find(player: player)

      assert_requested request
      player.verify
    end

    def test_extracts_id_from_team_object
      team = Minitest::Mock.new
      team.expect :id, 1_610_612_744
      request = stub_request(:get, /playerdashptshotdefend.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      PlayerDashPtShotDefend.find(player: 201_939, team: team)

      assert_requested request
      team.verify
    end

    def test_includes_team_id_in_path
      request = stub_request(:get, /playerdashptshotdefend.*TeamID=1610612744/).to_return(body: empty_response.to_json)
      PlayerDashPtShotDefend.find(player: 201_939, team: 1_610_612_744)

      assert_requested request
    end

    def test_includes_season_in_path
      request = stub_request(:get, /playerdashptshotdefend.*Season=2023-24/).to_return(body: empty_response.to_json)
      PlayerDashPtShotDefend.find(player: 201_939, season: 2023)

      assert_requested request
    end

    def test_includes_season_type_in_path
      request = stub_request(:get, /playerdashptshotdefend.*SeasonType=Playoffs/).to_return(body: empty_response.to_json)
      PlayerDashPtShotDefend.find(player: 201_939, season_type: "Playoffs")

      assert_requested request
    end

    def test_includes_per_mode_in_path
      request = stub_request(:get, /playerdashptshotdefend.*PerMode=Totals/).to_return(body: empty_response.to_json)
      PlayerDashPtShotDefend.find(player: 201_939, per_mode: "Totals")

      assert_requested request
    end

    def test_includes_league_id_in_path
      request = stub_request(:get, /playerdashptshotdefend.*LeagueID=00/).to_return(body: empty_response.to_json)
      PlayerDashPtShotDefend.find(player: 201_939)

      assert_requested request
    end

    private

    def empty_response
      {resultSets: [{name: "DefendingShots", headers: [], rowSet: []}]}
    end
  end
end
