require_relative "../test_helper"

module NBA
  class LeagueSeasonMatchupsOptionalParamsTest < Minitest::Test
    cover LeagueSeasonMatchups

    def test_all_without_off_player_excludes_from_path
      stub = stub_request(:get, /leagueseasonmatchups/)
        .with { |request| !request.uri.to_s.include?("OffPlayerID") }
        .to_return(body: matchups_response.to_json)

      LeagueSeasonMatchups.all(season: 2024)

      assert_requested stub
    end

    def test_all_without_def_player_excludes_from_path
      stub = stub_request(:get, /leagueseasonmatchups/)
        .with { |request| !request.uri.to_s.include?("DefPlayerID") }
        .to_return(body: matchups_response.to_json)

      LeagueSeasonMatchups.all(season: 2024)

      assert_requested stub
    end

    def test_all_without_off_team_excludes_from_path
      stub = stub_request(:get, /leagueseasonmatchups/)
        .with { |request| !request.uri.to_s.include?("OffTeamID") }
        .to_return(body: matchups_response.to_json)

      LeagueSeasonMatchups.all(season: 2024)

      assert_requested stub
    end

    def test_all_without_def_team_excludes_from_path
      stub = stub_request(:get, /leagueseasonmatchups/)
        .with { |request| !request.uri.to_s.include?("DefTeamID") }
        .to_return(body: matchups_response.to_json)

      LeagueSeasonMatchups.all(season: 2024)

      assert_requested stub
    end

    private

    def matchups_response
      {resultSets: [{name: "SeasonMatchups", headers: %w[SEASON_ID OFF_PLAYER_ID], rowSet: [["22024", 201_939]]}]}
    end
  end
end
