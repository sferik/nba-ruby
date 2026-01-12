require_relative "../../test_helper"

module NBA
  class PlayoffPictureAllTest < Minitest::Test
    cover PlayoffPicture

    def test_all_returns_collection
      stub_playoff_picture_request

      assert_instance_of Collection, PlayoffPicture.all
    end

    def test_all_parses_east_conference
      stub_playoff_picture_request

      matchup = PlayoffPicture.all.first

      assert_equal "East", matchup.conference
    end

    def test_all_parses_high_seed_info
      stub_playoff_picture_request

      matchup = PlayoffPicture.all.first

      assert_equal 1, matchup.high_seed_rank
      assert_equal "Boston Celtics", matchup.high_seed_team
      assert_equal Team::BOS, matchup.high_seed_team_id
    end

    def test_all_parses_low_seed_info
      stub_playoff_picture_request

      matchup = PlayoffPicture.all.first

      assert_equal 8, matchup.low_seed_rank
      assert_equal "Miami Heat", matchup.low_seed_team
      assert_equal Team::MIA, matchup.low_seed_team_id
    end

    def test_all_parses_series_info
      stub_playoff_picture_request

      matchup = PlayoffPicture.all.first

      assert_equal 4, matchup.high_seed_series_wins
      assert_equal 1, matchup.low_seed_series_wins
      assert_equal "Celtics lead 4-1", matchup.series_status
    end

    def test_all_parses_west_conference
      stub_playoff_picture_request

      matchup = PlayoffPicture.all.last

      assert_equal "West", matchup.conference
      assert_equal "Denver Nuggets", matchup.high_seed_team
    end

    def test_all_with_custom_season
      stub_request(:get, /playoffpicture.*SeasonID=22022/)
        .to_return(body: playoff_picture_response.to_json)

      PlayoffPicture.all(season: 2022)

      assert_requested :get, /playoffpicture.*SeasonID=22022/
    end

    def test_all_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /playoffpicture.*LeagueID=00/)
        .to_return(body: playoff_picture_response.to_json)

      PlayoffPicture.all(league: league)

      assert_requested :get, /playoffpicture.*LeagueID=00/
    end

    def test_all_with_league_string
      stub_request(:get, /playoffpicture.*LeagueID=00/)
        .to_return(body: playoff_picture_response.to_json)

      PlayoffPicture.all(league: "00")

      assert_requested :get, /playoffpicture.*LeagueID=00/
    end

    private

    def stub_playoff_picture_request
      stub_request(:get, /playoffpicture/).to_return(body: playoff_picture_response.to_json)
    end

    def playoff_picture_response
      {resultSets: [east_conf_result_set, west_conf_result_set]}
    end

    def east_conf_result_set
      {name: "EastConfPlayoffPicture", headers: playoff_headers, rowSet: [east_row]}
    end

    def west_conf_result_set
      {name: "WestConfPlayoffPicture", headers: playoff_headers, rowSet: [west_row]}
    end

    def playoff_headers
      %w[CONFERENCE HIGH_SEED_RANK HIGH_SEED_TEAM HIGH_SEED_TEAM_ID LOW_SEED_RANK
        LOW_SEED_TEAM LOW_SEED_TEAM_ID HIGH_SEED_SERIES_W LOW_SEED_SERIES_W SERIES_STATUS]
    end

    def east_row
      ["East", 1, "Boston Celtics", Team::BOS, 8, "Miami Heat", Team::MIA, 4, 1, "Celtics lead 4-1"]
    end

    def west_row
      ["West", 1, "Denver Nuggets", Team::DEN, 8, "Minnesota Timberwolves", Team::MIN, 4, 3, "Nuggets win 4-3"]
    end
  end
end
