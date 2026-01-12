require_relative "../../test_helper"

module NBA
  class LeadersTilesAllTest < Minitest::Test
    cover LeadersTiles

    def test_all_returns_collection
      stub_leaders_tiles_request

      assert_instance_of Collection, LeadersTiles.all
    end

    def test_all_parses_rank
      stub_leaders_tiles_request

      tile = LeadersTiles.all.first

      assert_equal 1, tile.rank
    end

    def test_all_parses_team_info
      stub_leaders_tiles_request

      tile = LeadersTiles.all.first

      assert_equal Team::BOS, tile.team_id
      assert_equal "BOS", tile.team_abbreviation
      assert_equal "Boston Celtics", tile.team_name
    end

    def test_all_parses_pts
      stub_leaders_tiles_request

      tile = LeadersTiles.all.first

      assert_in_delta 120.5, tile.pts
    end

    def test_all_with_all_time_high_result_set
      stub_request(:get, /leaderstiles/).to_return(body: all_time_high_response.to_json)

      tile = LeadersTiles.all(result_set: :all_time_high).first

      assert_equal Team::CHI, tile.team_id
      assert_equal "1995-96", tile.season_year
    end

    def test_all_with_custom_season
      stub_request(:get, /leaderstiles.*Season=2022-23/)
        .to_return(body: leaders_tiles_response.to_json)

      LeadersTiles.all(season: 2022)

      assert_requested :get, /leaderstiles.*Season=2022-23/
    end

    def test_all_with_playoffs_season_type
      stub_request(:get, /leaderstiles.*SeasonType=Playoffs/)
        .to_return(body: leaders_tiles_response.to_json)

      LeadersTiles.all(season_type: "Playoffs")

      assert_requested :get, /leaderstiles.*SeasonType=Playoffs/
    end

    def test_all_with_stat
      stub_request(:get, /leaderstiles.*Stat=REB/)
        .to_return(body: leaders_tiles_response.to_json)

      LeadersTiles.all(stat: "REB")

      assert_requested :get, /leaderstiles.*Stat=REB/
    end

    def test_all_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /leaderstiles.*LeagueID=00/)
        .to_return(body: leaders_tiles_response.to_json)

      LeadersTiles.all(league: league)

      assert_requested :get, /leaderstiles.*LeagueID=00/
    end

    def test_all_with_league_string
      stub_request(:get, /leaderstiles.*LeagueID=00/)
        .to_return(body: leaders_tiles_response.to_json)

      LeadersTiles.all(league: "00")

      assert_requested :get, /leaderstiles.*LeagueID=00/
    end

    private

    def stub_leaders_tiles_request
      stub_request(:get, /leaderstiles/).to_return(body: leaders_tiles_response.to_json)
    end

    def leaders_tiles_response
      {resultSets: [{name: "LeadersTiles",
                     headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME PTS],
                     rowSet: [[1, Team::BOS, "BOS", "Boston Celtics", 120.5]]}]}
    end

    def all_time_high_response
      {resultSets: [{name: "AllTimeSeasonHigh",
                     headers: %w[TEAM_ID TEAM_ABBREVIATION TEAM_NAME SEASON_YEAR PTS],
                     rowSet: [[Team::CHI, "CHI", "Chicago Bulls", "1995-96", 131.5]]}]}
    end
  end
end
