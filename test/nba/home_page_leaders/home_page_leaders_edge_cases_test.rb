require_relative "../../test_helper"

module NBA
  class HomePageLeadersEdgeCasesTest < Minitest::Test
    cover HomePageLeaders

    def test_all_handles_nil_response
      stub_request(:get, /homepageleaders/).to_return(body: nil)

      result = HomePageLeaders.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_result_sets
      stub_request(:get, /homepageleaders/).to_return(body: {resultSets: []}.to_json)

      result = HomePageLeaders.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_result_set
      response = {resultSets: [{name: "Other", headers: [], rowSet: []}]}
      stub_request(:get, /homepageleaders/).to_return(body: response.to_json)

      result = HomePageLeaders.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_empty_row_set
      response = {resultSets: [{name: "HomePageLeaders", headers: %w[RANK PLAYER_ID], rowSet: []}]}
      stub_request(:get, /homepageleaders/).to_return(body: response.to_json)

      result = HomePageLeaders.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_handles_missing_rank
      response = {resultSets: [{name: "HomePageLeaders",
                                headers: %w[PLAYER_ID PLAYER],
                                rowSet: [[201_566, "Russell Westbrook"]]}]}
      stub_request(:get, /homepageleaders/).to_return(body: response.to_json)

      leader = HomePageLeaders.all.first

      assert_nil leader.rank
      assert_equal 201_566, leader.player_id
    end

    def test_all_handles_missing_player_id
      response = {resultSets: [{name: "HomePageLeaders",
                                headers: %w[RANK PLAYER],
                                rowSet: [[1, "Russell Westbrook"]]}]}
      stub_request(:get, /homepageleaders/).to_return(body: response.to_json)

      leader = HomePageLeaders.all.first

      assert_equal 1, leader.rank
      assert_nil leader.player_id
    end

    def test_all_selects_correct_result_set_from_multiple
      response = {resultSets: [
        {name: "WrongSet", headers: %w[WRONG_COL], rowSet: [["wrong_data"]]},
        {name: "HomePageLeaders", headers: %w[RANK PLAYER_ID PLAYER TEAM_ID],
         rowSet: [[1, 201_566, "Russell Westbrook", Team::LAC]]}
      ]}
      stub_request(:get, /homepageleaders/).to_return(body: response.to_json)

      leader = HomePageLeaders.all.first

      assert_equal 1, leader.rank
      assert_equal "Russell Westbrook", leader.player
    end

    def test_all_default_league_is_nba
      stub_request(:get, /homepageleaders.*LeagueID=00/)
        .to_return(body: {resultSets: [{name: "HomePageLeaders", headers: %w[RANK], rowSet: [[1]]}]}.to_json)

      HomePageLeaders.all

      assert_requested :get, /homepageleaders.*LeagueID=00/
    end

    def test_all_default_season_type_is_regular_season
      stub_request(:get, /homepageleaders.*SeasonType=Regular%20Season/)
        .to_return(body: {resultSets: [{name: "HomePageLeaders", headers: %w[RANK], rowSet: [[1]]}]}.to_json)

      HomePageLeaders.all

      assert_requested :get, /homepageleaders.*SeasonType=Regular%20Season/
    end

    def test_all_default_stat_category_is_pts
      stub_request(:get, /homepageleaders.*StatCategory=PTS/)
        .to_return(body: {resultSets: [{name: "HomePageLeaders", headers: %w[RANK], rowSet: [[1]]}]}.to_json)

      HomePageLeaders.all

      assert_requested :get, /homepageleaders.*StatCategory=PTS/
    end

    def test_all_default_game_scope_is_season
      stub_request(:get, /homepageleaders.*GameScope=Season/)
        .to_return(body: {resultSets: [{name: "HomePageLeaders", headers: %w[RANK], rowSet: [[1]]}]}.to_json)

      HomePageLeaders.all

      assert_requested :get, /homepageleaders.*GameScope=Season/
    end

    def test_all_default_player_or_team_is_player
      stub_request(:get, /homepageleaders.*PlayerOrTeam=Player/)
        .to_return(body: {resultSets: [{name: "HomePageLeaders", headers: %w[RANK], rowSet: [[1]]}]}.to_json)

      HomePageLeaders.all

      assert_requested :get, /homepageleaders.*PlayerOrTeam=Player/
    end

    def test_all_default_player_scope_is_all_players
      stub_request(:get, /homepageleaders.*PlayerScope=All%20Players/)
        .to_return(body: {resultSets: [{name: "HomePageLeaders", headers: %w[RANK], rowSet: [[1]]}]}.to_json)

      HomePageLeaders.all

      assert_requested :get, /homepageleaders.*PlayerScope=All%20Players/
    end
  end
end
