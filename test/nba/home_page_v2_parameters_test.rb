require_relative "../test_helper"

module NBA
  class HomePageV2ParametersTest < Minitest::Test
    cover HomePageV2

    def test_all_with_custom_season
      stub_request(:get, /homepagev2.*Season=2022-23/)
        .to_return(body: home_page_v2_response.to_json)

      HomePageV2.all(stat_category: :pts, season: 2022)

      assert_requested :get, /homepagev2.*Season=2022-23/
    end

    def test_all_with_playoffs_season_type
      stub_request(:get, /homepagev2.*SeasonType=Playoffs/)
        .to_return(body: home_page_v2_response.to_json)

      HomePageV2.all(stat_category: :pts, season_type: "Playoffs")

      assert_requested :get, /homepagev2.*SeasonType=Playoffs/
    end

    def test_all_with_stat_type
      stub_request(:get, /homepagev2.*StatType=Advanced/)
        .to_return(body: home_page_v2_response.to_json)

      HomePageV2.all(stat_category: :pts, stat_type: "Advanced")

      assert_requested :get, /homepagev2.*StatType=Advanced/
    end

    def test_all_with_game_scope
      stub_request(:get, /homepagev2.*GameScope=Yesterday/)
        .to_return(body: home_page_v2_response.to_json)

      HomePageV2.all(stat_category: :pts, game_scope: "Yesterday")

      assert_requested :get, /homepagev2.*GameScope=Yesterday/
    end

    def test_all_with_player_or_team
      stub_request(:get, /homepagev2.*PlayerOrTeam=Player/)
        .to_return(body: home_page_v2_response.to_json)

      HomePageV2.all(stat_category: :pts, player_or_team: "Player")

      assert_requested :get, /homepagev2.*PlayerOrTeam=Player/
    end

    def test_all_with_player_scope
      stub_request(:get, /homepagev2.*PlayerScope=Rookies/)
        .to_return(body: home_page_v2_response.to_json)

      HomePageV2.all(stat_category: :pts, player_scope: "Rookies")

      assert_requested :get, /homepagev2.*PlayerScope=Rookies/
    end

    def test_all_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /homepagev2.*LeagueID=00/)
        .to_return(body: home_page_v2_response.to_json)

      HomePageV2.all(stat_category: :pts, league: league)

      assert_requested :get, /homepagev2.*LeagueID=00/
    end

    def test_all_with_league_string
      stub_request(:get, /homepagev2.*LeagueID=00/)
        .to_return(body: home_page_v2_response.to_json)

      HomePageV2.all(stat_category: :pts, league: "00")

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
