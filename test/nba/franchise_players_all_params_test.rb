require_relative "franchise_players_all_helper"

module NBA
  class FranchisePlayersAllParamsTest < Minitest::Test
    include FranchisePlayersAllHelper

    cover FranchisePlayers

    def setup
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)
    end

    def test_all_with_custom_season_type
      FranchisePlayers.all(team: Team::GSW, season_type: "Playoffs")

      assert_requested :get, /franchiseplayers.*SeasonType=Playoffs/
    end

    def test_all_with_custom_per_mode
      FranchisePlayers.all(team: Team::GSW, per_mode: FranchisePlayers::TOTALS)

      assert_requested :get, /franchiseplayers.*PerMode=Totals/
    end

    def test_all_uses_default_per_mode
      FranchisePlayers.all(team: Team::GSW)

      assert_requested :get, /franchiseplayers.*PerMode=PerGame/
    end

    def test_all_uses_default_season_type
      FranchisePlayers.all(team: Team::GSW)

      assert_requested :get, /franchiseplayers.*SeasonType=Regular%20Season/
    end

    def test_all_uses_default_league_id
      FranchisePlayers.all(team: Team::GSW)

      assert_requested :get, /franchiseplayers.*LeagueID=00/
    end

    def test_all_accepts_custom_league_id
      FranchisePlayers.all(team: Team::GSW, league: "10")

      assert_requested :get, /franchiseplayers.*LeagueID=10/
    end

    def test_all_accepts_league_object
      league = League.new(id: "10", name: "WNBA")

      FranchisePlayers.all(team: Team::GSW, league: league)

      assert_requested :get, /franchiseplayers.*LeagueID=10/
    end
  end
end
