require_relative "../test_helper"

module NBA
  class AssistLeadersAllTest < Minitest::Test
    cover AssistLeaders

    def test_all_returns_collection
      stub_assist_leaders_request

      assert_instance_of Collection, AssistLeaders.all
    end

    def test_all_parses_player_info
      stub_assist_leaders_request

      leader = AssistLeaders.all.first

      assert_equal 201_566, leader.player_id
      assert_equal "Russell Westbrook", leader.player_name
      assert_equal Team::LAC, leader.team_id
      assert_equal "LAC", leader.team_abbreviation
    end

    def test_all_parses_rank_and_ast
      stub_assist_leaders_request

      leader = AssistLeaders.all.first

      assert_equal 1, leader.rank
      assert_equal 654, leader.ast
    end

    def test_all_with_custom_season
      stub_request(:get, /assistleaders.*Season=2022-23/)
        .to_return(body: assist_leaders_response.to_json)

      AssistLeaders.all(season: 2022)

      assert_requested :get, /assistleaders.*Season=2022-23/
    end

    def test_all_with_playoffs_season_type
      stub_request(:get, /assistleaders.*SeasonType=Playoffs/)
        .to_return(body: assist_leaders_response.to_json)

      AssistLeaders.all(season_type: "Playoffs")

      assert_requested :get, /assistleaders.*SeasonType=Playoffs/
    end

    def test_all_default_season_type_is_regular_season
      stub_request(:get, /assistleaders.*SeasonType=Regular%20Season/)
        .to_return(body: assist_leaders_response.to_json)

      AssistLeaders.all

      assert_requested :get, /assistleaders.*SeasonType=Regular%20Season/
    end

    def test_all_with_per_game_mode
      stub_request(:get, /assistleaders.*PerMode=PerGame/)
        .to_return(body: assist_leaders_response.to_json)

      AssistLeaders.all(per_mode: "PerGame")

      assert_requested :get, /assistleaders.*PerMode=PerGame/
    end

    def test_all_default_per_mode_is_totals
      stub_request(:get, /assistleaders.*PerMode=Totals/)
        .to_return(body: assist_leaders_response.to_json)

      AssistLeaders.all

      assert_requested :get, /assistleaders.*PerMode=Totals/
    end

    def test_all_with_team_player_or_team
      stub_request(:get, /assistleaders.*PlayerOrTeam=Team/)
        .to_return(body: assist_leaders_response.to_json)

      AssistLeaders.all(player_or_team: "Team")

      assert_requested :get, /assistleaders.*PlayerOrTeam=Team/
    end

    def test_all_default_player_or_team_is_player
      stub_request(:get, /assistleaders.*PlayerOrTeam=Player/)
        .to_return(body: assist_leaders_response.to_json)

      AssistLeaders.all

      assert_requested :get, /assistleaders.*PlayerOrTeam=Player/
    end

    def test_all_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /assistleaders.*LeagueID=00/)
        .to_return(body: assist_leaders_response.to_json)

      AssistLeaders.all(league: league)

      assert_requested :get, /assistleaders.*LeagueID=00/
    end

    def test_all_with_league_string
      stub_request(:get, /assistleaders.*LeagueID=00/)
        .to_return(body: assist_leaders_response.to_json)

      AssistLeaders.all(league: "00")

      assert_requested :get, /assistleaders.*LeagueID=00/
    end

    private

    def stub_assist_leaders_request
      stub_request(:get, /assistleaders/).to_return(body: assist_leaders_response.to_json)
    end

    def assist_leaders_response
      {resultSets: [{name: "AssistLeaders", headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AST],
                     rowSet: [[1, 201_566, "Russell Westbrook", Team::LAC, "LAC", 654]]}]}
    end
  end
end
