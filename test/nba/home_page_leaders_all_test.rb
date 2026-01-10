require_relative "../test_helper"

module NBA
  class HomePageLeadersAllTest < Minitest::Test
    cover HomePageLeaders

    def test_all_returns_collection
      stub_home_page_leaders_request

      assert_instance_of Collection, HomePageLeaders.all
    end

    def test_all_parses_rank
      stub_home_page_leaders_request

      leader = HomePageLeaders.all.first

      assert_equal 1, leader.rank
    end

    def test_all_parses_player_info
      stub_home_page_leaders_request

      leader = HomePageLeaders.all.first

      assert_equal 201_566, leader.player_id
      assert_equal "Russell Westbrook", leader.player
      assert_equal Team::LAC, leader.team_id
      assert_equal "LAC", leader.team_abbreviation
    end

    def test_all_parses_stats
      stub_home_page_leaders_request

      leader = HomePageLeaders.all.first

      assert_in_delta 25.5, leader.pts
      assert_in_delta 0.475, leader.fg_pct
    end

    def test_all_parses_additional_stats
      stub_home_page_leaders_request

      leader = HomePageLeaders.all.first

      assert_in_delta 0.385, leader.fg3_pct
      assert_in_delta 0.875, leader.ft_pct
      assert_in_delta 28.3, leader.eff
      assert_in_delta 8.5, leader.ast
      assert_in_delta 7.2, leader.reb
    end

    def test_all_with_custom_season
      stub_request(:get, /homepageleaders.*Season=2022-23/)
        .to_return(body: home_page_leaders_response.to_json)

      HomePageLeaders.all(season: 2022)

      assert_requested :get, /homepageleaders.*Season=2022-23/
    end

    def test_all_with_playoffs_season_type
      stub_request(:get, /homepageleaders.*SeasonType=Playoffs/)
        .to_return(body: home_page_leaders_response.to_json)

      HomePageLeaders.all(season_type: "Playoffs")

      assert_requested :get, /homepageleaders.*SeasonType=Playoffs/
    end

    def test_all_with_stat_category
      stub_request(:get, /homepageleaders.*StatCategory=AST/)
        .to_return(body: home_page_leaders_response.to_json)

      HomePageLeaders.all(stat_category: "AST")

      assert_requested :get, /homepageleaders.*StatCategory=AST/
    end

    def test_all_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /homepageleaders.*LeagueID=00/)
        .to_return(body: home_page_leaders_response.to_json)

      HomePageLeaders.all(league: league)

      assert_requested :get, /homepageleaders.*LeagueID=00/
    end

    def test_all_with_league_string
      stub_request(:get, /homepageleaders.*LeagueID=00/)
        .to_return(body: home_page_leaders_response.to_json)

      HomePageLeaders.all(league: "00")

      assert_requested :get, /homepageleaders.*LeagueID=00/
    end

    private

    def stub_home_page_leaders_request
      stub_request(:get, /homepageleaders/).to_return(body: home_page_leaders_response.to_json)
    end

    def home_page_leaders_response
      {resultSets: [{name: "HomePageLeaders",
                     headers: %w[RANK PLAYER_ID PLAYER TEAM_ID TEAM_ABBREVIATION PTS FG_PCT
                       FG3_PCT FT_PCT EFF AST REB],
                     rowSet: [[1, 201_566, "Russell Westbrook", Team::LAC, "LAC", 25.5, 0.475,
                       0.385, 0.875, 28.3, 8.5, 7.2]]}]}
    end
  end
end
