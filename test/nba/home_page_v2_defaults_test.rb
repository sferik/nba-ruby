require_relative "../test_helper"

module NBA
  class HomePageV2DefaultsTest < Minitest::Test
    cover HomePageV2

    def test_all_default_season_type_is_regular_season
      stub_request(:get, /homepagev2.*SeasonType=Regular%20Season/)
        .to_return(body: home_page_v2_response.to_json)

      HomePageV2.all(stat_category: :pts)

      assert_requested :get, /homepagev2.*SeasonType=Regular%20Season/
    end

    def test_all_default_game_scope_is_season
      stub_request(:get, /homepagev2.*GameScope=Season/)
        .to_return(body: home_page_v2_response.to_json)

      HomePageV2.all(stat_category: :pts)

      assert_requested :get, /homepagev2.*GameScope=Season/
    end

    def test_all_default_player_or_team_is_team
      stub_request(:get, /homepagev2.*PlayerOrTeam=Team/)
        .to_return(body: home_page_v2_response.to_json)

      HomePageV2.all(stat_category: :pts)

      assert_requested :get, /homepagev2.*PlayerOrTeam=Team/
    end

    def test_all_default_player_scope_is_all_players
      stub_request(:get, /homepagev2.*PlayerScope=All%20Players/)
        .to_return(body: home_page_v2_response.to_json)

      HomePageV2.all(stat_category: :pts)

      assert_requested :get, /homepagev2.*PlayerScope=All%20Players/
    end

    def test_all_default_stat_type_is_traditional
      stub_request(:get, /homepagev2.*StatType=Traditional/)
        .to_return(body: home_page_v2_response.to_json)

      HomePageV2.all(stat_category: :pts)

      assert_requested :get, /homepagev2.*StatType=Traditional/
    end

    def test_all_default_league_is_nba
      stub_request(:get, /homepagev2.*LeagueID=00/)
        .to_return(body: home_page_v2_response.to_json)

      HomePageV2.all(stat_category: :pts)

      assert_requested :get, /homepagev2.*LeagueID=00/
    end

    private

    def home_page_v2_response
      {resultSets: [{name: "HomePageStat1",
                     headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME PTS],
                     rowSet: [[1, Team::BOS, "BOS", "Boston Celtics", 120.5]]}]}
    end
  end
end
