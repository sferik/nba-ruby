require_relative "../test_helper"

module NBA
  class LeagueStandingsAllDefaultParameterTest < Minitest::Test
    cover LeagueStandings

    def test_all_uses_default_season_type
      stub_standings_request

      LeagueStandings.all(season: 2024)

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_all_uses_default_league_id
      stub_standings_request

      LeagueStandings.all(season: 2024)

      assert_requested :get, /LeagueID=00/
    end

    def test_all_uses_default_season_from_utils
      stub_standings_request
      expected_season = Utils.current_season
      expected_str = "#{expected_season}-#{(expected_season + 1).to_s[-2..]}"

      LeagueStandings.all

      assert_requested :get, /Season=#{expected_str}/
    end

    def test_conference_uses_default_season_from_utils
      stub_standings_request
      expected_season = Utils.current_season
      expected_str = "#{expected_season}-#{(expected_season + 1).to_s[-2..]}"

      LeagueStandings.conference("West")

      assert_requested :get, /Season=#{expected_str}/
    end

    def test_conference_uses_default_season_type
      stub_standings_request

      LeagueStandings.conference("West")

      assert_requested :get, /SeasonType=Regular%20Season/
    end

    def test_conference_uses_default_league_id
      stub_standings_request

      LeagueStandings.conference("West")

      assert_requested :get, /LeagueID=00/
    end

    private

    def stub_standings_request
      stub_request(:get, /leaguestandingsv3/).to_return(body: {resultSets: []}.to_json)
    end
  end
end
