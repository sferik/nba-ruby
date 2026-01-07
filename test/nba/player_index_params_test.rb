require_relative "../test_helper"

module NBA
  class PlayerIndexParamsTest < Minitest::Test
    cover PlayerIndex

    def test_all_with_custom_season
      stub_request(:get, /playerindex.*Season=2023-24/).to_return(body: player_index_response.to_json)

      PlayerIndex.all(season: 2023)

      assert_requested :get, /playerindex.*Season=2023-24/
    end

    def test_all_with_historical_flag
      stub_request(:get, /playerindex.*Historical=1/).to_return(body: player_index_response.to_json)

      PlayerIndex.all(historical: PlayerIndex::HISTORICAL)

      assert_requested :get, /playerindex.*Historical=1/
    end

    def test_all_default_historical_is_current
      stub_request(:get, /playerindex.*Historical=0/).to_return(body: player_index_response.to_json)

      PlayerIndex.all

      assert_requested :get, /playerindex.*Historical=0/
    end

    def test_all_with_college_filter
      stub_request(:get, /playerindex.*College=Duke/).to_return(body: player_index_response.to_json)

      PlayerIndex.all(college: "Duke")

      assert_requested :get, /playerindex.*College=Duke/
    end

    def test_all_with_country_filter
      stub_request(:get, /playerindex.*Country=Canada/).to_return(body: player_index_response.to_json)

      PlayerIndex.all(country: "Canada")

      assert_requested :get, /playerindex.*Country=Canada/
    end

    def test_all_with_team_filter_using_id
      stub_request(:get, /playerindex.*TeamID=1610612744/).to_return(body: player_index_response.to_json)

      PlayerIndex.all(team: 1_610_612_744)

      assert_requested :get, /playerindex.*TeamID=1610612744/
    end

    def test_all_with_team_filter_using_team_object
      stub_request(:get, /playerindex.*TeamID=1610612744/).to_return(body: player_index_response.to_json)
      team = Team.new(id: 1_610_612_744)

      PlayerIndex.all(team: team)

      assert_requested :get, /playerindex.*TeamID=1610612744/
    end

    def test_all_without_team_sends_nil_team_id
      stub_request(:get, /playerindex.*TeamID=&/).to_return(body: player_index_response.to_json)

      PlayerIndex.all(team: nil)

      assert_requested :get, /playerindex.*TeamID=&/
    end

    def test_all_with_active_filter
      stub_request(:get, /playerindex.*Active=1/).to_return(body: player_index_response.to_json)

      PlayerIndex.all(active: "1")

      assert_requested :get, /playerindex.*Active=1/
    end

    def test_all_with_all_star_filter
      stub_request(:get, /playerindex.*AllStar=1/).to_return(body: player_index_response.to_json)

      PlayerIndex.all(all_star: "1")

      assert_requested :get, /playerindex.*AllStar=1/
    end

    def test_all_with_draft_pick_filter
      stub_request(:get, /playerindex.*DraftPick=1/).to_return(body: player_index_response.to_json)

      PlayerIndex.all(draft_pick: "1")

      assert_requested :get, /playerindex.*DraftPick=1/
    end

    def test_all_with_draft_year_filter
      stub_request(:get, /playerindex.*DraftYear=2009/).to_return(body: player_index_response.to_json)

      PlayerIndex.all(draft_year: "2009")

      assert_requested :get, /playerindex.*DraftYear=2009/
    end

    def test_all_with_height_filter
      stub_request(:get, /playerindex.*Height=6-2/).to_return(body: player_index_response.to_json)

      PlayerIndex.all(height: "6-2")

      assert_requested :get, /playerindex.*Height=6-2/
    end

    def test_all_with_weight_filter
      stub_request(:get, /playerindex.*Weight=185/).to_return(body: player_index_response.to_json)

      PlayerIndex.all(weight: "185")

      assert_requested :get, /playerindex.*Weight=185/
    end

    private

    def player_headers
      %w[PERSON_ID PLAYER_LAST_NAME PLAYER_FIRST_NAME PLAYER_SLUG
        TEAM_ID TEAM_SLUG TEAM_CITY TEAM_NAME TEAM_ABBREVIATION
        JERSEY_NUMBER POSITION HEIGHT WEIGHT COLLEGE COUNTRY
        DRAFT_YEAR DRAFT_ROUND DRAFT_NUMBER ROSTER_STATUS
        PTS REB AST STATS_TIMEFRAME FROM_YEAR TO_YEAR IS_DEFUNCT]
    end

    def player_index_response
      {resultSets: [{name: "PlayerIndex", headers: player_headers, rowSet: [player_row]}]}
    end

    def player_row
      [201_939, "Curry", "Stephen", "stephen-curry",
        1_610_612_744, "warriors", "Golden State", "Warriors", "GSW",
        "30", "G", "6-2", 185, "Davidson", "USA",
        2009, 1, 7, 1,
        24.8, 4.7, 6.5, "Season", 2009, 2024, 0]
    end
  end
end
