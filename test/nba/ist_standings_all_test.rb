require_relative "../test_helper"

module NBA
  class IstStandingsAllTest < Minitest::Test
    cover IstStandings

    def test_all_returns_collection
      stub_ist_standings_request

      assert_instance_of Collection, IstStandings.all
    end

    def test_all_parses_season_and_team_id
      stub_ist_standings_request

      standing = IstStandings.all.first

      assert_equal "2023-24", standing.season_id
      assert_equal Team::LAL, standing.team_id
    end

    def test_all_parses_team_name_info
      stub_ist_standings_request

      standing = IstStandings.all.first

      assert_equal "Los Angeles", standing.team_city
      assert_equal "Lakers", standing.team_name
      assert_equal "LAL", standing.team_abbreviation
      assert_equal "lakers", standing.team_slug
    end

    def test_all_parses_conference_and_group
      stub_ist_standings_request

      standing = IstStandings.all.first

      assert_equal "West", standing.conference
      assert_equal "West Group A", standing.ist_group
    end

    def test_all_parses_record_info
      stub_ist_standings_request

      standing = IstStandings.all.first

      assert_equal 1, standing.ist_group_rank
      assert_equal 3, standing.wins
      assert_equal 1, standing.losses
      assert_in_delta 0.750, standing.win_pct
      assert_equal "z", standing.clinch_indicator
    end

    def test_all_parses_points_info
      stub_ist_standings_request

      standing = IstStandings.all.first

      assert_equal 450, standing.pts_for
      assert_equal 420, standing.pts_against
      assert_equal 30, standing.pts_diff
    end

    def test_all_with_custom_season
      stub_request(:get, /iststandings.*Season=2022-23/)
        .to_return(body: ist_standings_response.to_json)

      IstStandings.all(season: 2022)

      assert_requested :get, /iststandings.*Season=2022-23/
    end

    def test_all_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /iststandings.*LeagueID=00/)
        .to_return(body: ist_standings_response.to_json)

      IstStandings.all(league: league)

      assert_requested :get, /iststandings.*LeagueID=00/
    end

    def test_all_with_league_string
      stub_request(:get, /iststandings.*LeagueID=00/)
        .to_return(body: ist_standings_response.to_json)

      IstStandings.all(league: "00")

      assert_requested :get, /iststandings.*LeagueID=00/
    end

    private

    def stub_ist_standings_request
      stub_request(:get, /iststandings/).to_return(body: ist_standings_response.to_json)
    end

    def ist_standings_response
      {resultSets: [{name: "Standings",
                     headers: %w[SEASON_ID TEAM_ID TEAM_CITY TEAM_NAME TEAM_ABBREVIATION TEAM_SLUG
                       CONFERENCE IST_GROUP IST_GROUP_RANK WINS LOSSES WIN_PCT PTS_FOR PTS_AGAINST
                       PTS_DIFF CLINCH_INDICATOR],
                     rowSet: [["2023-24", Team::LAL, "Los Angeles", "Lakers", "LAL", "lakers",
                       "West", "West Group A", 1, 3, 1, 0.750, 450, 420, 30, "z"]]}]}
    end
  end
end
