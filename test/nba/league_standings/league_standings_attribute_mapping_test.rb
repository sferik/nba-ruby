require_relative "../../test_helper"

module NBA
  class LeagueStandingsAttributeMappingTest < Minitest::Test
    cover LeagueStandings

    def test_maps_team_identity_attributes
      stub_standings_request

      standing = LeagueStandings.all(season: 2024).first

      assert_equal Team::GSW, standing.team_id
      assert_equal "Golden State", standing.team_city
      assert_equal "Warriors", standing.team_name
      assert_equal "warriors", standing.team_slug
      assert_equal "", standing.clinch_indicator
    end

    def test_maps_league_and_conference_attributes
      stub_standings_request

      standing = LeagueStandings.all(season: 2024).first

      assert_equal "00", standing.league_id
      assert_equal "22024", standing.season_id
      assert_equal "West", standing.conference
      assert_equal "Pacific", standing.division
    end

    def test_maps_basic_record_attributes
      stub_standings_request

      standing = LeagueStandings.all(season: 2024).first

      assert_equal 46, standing.wins
      assert_equal 36, standing.losses
      assert_in_delta 0.561, standing.win_pct
      assert_equal "46-36", standing.record
    end

    def test_maps_home_road_record_attributes
      stub_standings_request

      standing = LeagueStandings.all(season: 2024).first

      assert_equal "28-13", standing.home_record
      assert_equal "18-23", standing.road_record
      assert_in_delta 9.0, standing.conference_games_back
    end

    def test_maps_rank_and_division_attributes
      stub_standings_request

      standing = LeagueStandings.all(season: 2024).first

      assert_equal "30-22", standing.conference_record
      assert_equal 10, standing.playoff_rank
      assert_equal "9-7", standing.division_record
      assert_equal 3, standing.division_rank
      assert_equal 15, standing.league_rank
    end

    def test_maps_streak_record_attributes
      stub_standings_request

      standing = LeagueStandings.all(season: 2024).first

      assert_equal "6-4", standing.l10_record
      assert_equal 7, standing.long_win_streak
      assert_equal 5, standing.long_loss_streak
      assert_equal "W2", standing.current_streak
    end

    def test_maps_clinch_and_elimination_attributes
      stub_standings_request

      standing = LeagueStandings.all(season: 2024).first

      assert_equal 0, standing.clinched_conference_title
      assert_equal 1, standing.clinched_playoff_birth
      assert_equal 0, standing.eliminated_conference
    end

    def test_maps_all_points_attributes
      stub_standings_request

      standing = LeagueStandings.all(season: 2024).first

      assert_in_delta 118.7, standing.points_pg
      assert_in_delta 115.2, standing.opp_points_pg
      assert_in_delta 3.5, standing.diff_points_pg
    end

    private

    def stub_standings_request
      stub_request(:get, /leaguestandingsv3/).to_return(body: standings_response.to_json)
    end

    def standings_response
      {resultSets: [{name: "Standings", headers: standing_headers, rowSet: [standing_row]}]}
    end

    def standing_headers
      %w[LeagueID SeasonID TeamID TeamCity TeamName TeamSlug Conference ConferenceRecord
        PlayoffRank ClinchIndicator Division DivisionRecord DivisionRank WINS LOSSES
        WinPCT LeagueRank Record HOME ROAD L10 LongWinStreak LongLossStreak CurrentStreak
        ConferenceGamesBack ClinchedConferenceTitle ClinchedPlayoffBirth EliminatedConference
        PointsPG OppPointsPG DiffPointsPG]
    end

    def standing_row
      ["00", "22024", Team::GSW, "Golden State", "Warriors", "warriors", "West", "30-22",
        10, "", "Pacific", "9-7", 3, 46, 36, 0.561, 15, "46-36", "28-13", "18-23", "6-4",
        7, 5, "W2", 9.0, 0, 1, 0, 118.7, 115.2, 3.5]
    end
  end
end
