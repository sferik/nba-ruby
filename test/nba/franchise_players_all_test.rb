require_relative "../test_helper"

module NBA
  module FranchisePlayersAllHelper
    PLAYER_HEADERS = %w[LEAGUE_ID TEAM_ID TEAM PERSON_ID PLAYER SEASON_TYPE ACTIVE_WITH_TEAM GP
      FGM FGA FG_PCT FG3M FG3A FG3_PCT FTM FTA FT_PCT OREB DREB REB AST PF STL TOV BLK PTS].freeze

    PLAYER_ROW = ["00", Team::GSW, "Golden State Warriors", 201_939, "Stephen Curry", "Regular Season", "Y", 745,
      9.2, 19.3, 0.476, 4.5, 11.2, 0.426, 4.8, 5.3, 0.908, 0.5, 4.5, 5.0, 6.5, 2.1, 1.6, 3.1, 0.2, 24.8].freeze

    def response
      {resultSets: [{name: "FranchisePlayers", headers: PLAYER_HEADERS, rowSet: [PLAYER_ROW]}]}
    end

    def find_first
      FranchisePlayers.all(team: Team::GSW).first
    end
  end

  class FranchisePlayersAllBasicTest < Minitest::Test
    include FranchisePlayersAllHelper

    cover FranchisePlayers

    def setup
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)
    end

    def test_all_returns_collection
      assert_instance_of Collection, FranchisePlayers.all(team: Team::GSW)
    end

    def test_all_uses_team_id_parameter
      FranchisePlayers.all(team: Team::GSW)

      assert_requested :get, /franchiseplayers.*TeamID=#{Team::GSW}/o
    end

    def test_all_accepts_team_object
      team = Team.new(id: Team::GSW, full_name: "Golden State Warriors")

      FranchisePlayers.all(team: team)

      assert_requested :get, /franchiseplayers.*TeamID=#{Team::GSW}/o
    end

    def test_all_uses_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, response.to_json, [String]

      result = FranchisePlayers.all(team: Team::GSW, client: mock_client)

      assert_equal 1, result.size
      mock_client.verify
    end
  end

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

  class FranchisePlayersAllIdentityTest < Minitest::Test
    include FranchisePlayersAllHelper

    cover FranchisePlayers

    def setup
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)
    end

    def test_all_parses_league_id
      assert_equal "00", find_first.league_id
    end

    def test_all_parses_team_id
      assert_equal Team::GSW, find_first.team_id
    end

    def test_all_parses_team
      assert_equal "Golden State Warriors", find_first.team
    end

    def test_all_parses_person_id
      assert_equal 201_939, find_first.person_id
    end

    def test_all_parses_player_name
      assert_equal "Stephen Curry", find_first.player
    end

    def test_all_parses_season_type
      assert_equal "Regular Season", find_first.season_type
    end

    def test_all_parses_active_with_team
      assert_equal "Y", find_first.active_with_team
    end

    def test_all_parses_gp
      assert_equal 745, find_first.gp
    end
  end

  class FranchisePlayersAllShotTest < Minitest::Test
    include FranchisePlayersAllHelper

    cover FranchisePlayers

    def setup
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)
    end

    def test_all_parses_fgm
      assert_in_delta(9.2, find_first.fgm)
    end

    def test_all_parses_fga
      assert_in_delta(19.3, find_first.fga)
    end

    def test_all_parses_fg_pct
      assert_in_delta(0.476, find_first.fg_pct)
    end

    def test_all_parses_fg3m
      assert_in_delta(4.5, find_first.fg3m)
    end

    def test_all_parses_fg3a
      assert_in_delta(11.2, find_first.fg3a)
    end

    def test_all_parses_fg3_pct
      assert_in_delta(0.426, find_first.fg3_pct)
    end

    def test_all_parses_ftm
      assert_in_delta(4.8, find_first.ftm)
    end

    def test_all_parses_fta
      assert_in_delta(5.3, find_first.fta)
    end

    def test_all_parses_ft_pct
      assert_in_delta(0.908, find_first.ft_pct)
    end
  end

  class FranchisePlayersAllOtherTest < Minitest::Test
    include FranchisePlayersAllHelper

    cover FranchisePlayers

    def setup
      stub_request(:get, /franchiseplayers/).to_return(body: response.to_json)
    end

    def test_all_parses_oreb
      assert_in_delta(0.5, find_first.oreb)
    end

    def test_all_parses_dreb
      assert_in_delta(4.5, find_first.dreb)
    end

    def test_all_parses_reb
      assert_in_delta(5.0, find_first.reb)
    end

    def test_all_parses_ast
      assert_in_delta(6.5, find_first.ast)
    end

    def test_all_parses_pf
      assert_in_delta(2.1, find_first.pf)
    end

    def test_all_parses_stl
      assert_in_delta(1.6, find_first.stl)
    end

    def test_all_parses_tov
      assert_in_delta(3.1, find_first.tov)
    end

    def test_all_parses_blk
      assert_in_delta(0.2, find_first.blk)
    end

    def test_all_parses_pts
      assert_in_delta(24.8, find_first.pts)
    end
  end
end
