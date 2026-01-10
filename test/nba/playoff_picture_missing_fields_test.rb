require_relative "../test_helper"

module NBA
  class PlayoffPictureMissingFieldsTest < Minitest::Test
    cover PlayoffPicture

    def test_all_handles_missing_high_seed_rank
      response = build_response_without("HIGH_SEED_RANK")
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      matchup = PlayoffPicture.all.first

      assert_nil matchup.high_seed_rank
      assert_equal "Boston Celtics", matchup.high_seed_team
    end

    def test_all_handles_missing_high_seed_team
      response = build_response_without("HIGH_SEED_TEAM")
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      matchup = PlayoffPicture.all.first

      assert_nil matchup.high_seed_team
      assert_equal 1, matchup.high_seed_rank
    end

    def test_all_handles_missing_high_seed_team_id
      response = build_response_without("HIGH_SEED_TEAM_ID")
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      matchup = PlayoffPicture.all.first

      assert_nil matchup.high_seed_team_id
      assert_equal "Boston Celtics", matchup.high_seed_team
    end

    def test_all_handles_missing_low_seed_rank
      response = build_response_without("LOW_SEED_RANK")
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      matchup = PlayoffPicture.all.first

      assert_nil matchup.low_seed_rank
      assert_equal "Miami Heat", matchup.low_seed_team
    end

    def test_all_handles_missing_low_seed_team
      response = build_response_without("LOW_SEED_TEAM")
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      matchup = PlayoffPicture.all.first

      assert_nil matchup.low_seed_team
      assert_equal 8, matchup.low_seed_rank
    end

    def test_all_handles_missing_low_seed_team_id
      response = build_response_without("LOW_SEED_TEAM_ID")
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      matchup = PlayoffPicture.all.first

      assert_nil matchup.low_seed_team_id
      assert_equal "Miami Heat", matchup.low_seed_team
    end

    def test_all_handles_missing_high_seed_series_w
      response = build_response_without("HIGH_SEED_SERIES_W")
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      matchup = PlayoffPicture.all.first

      assert_nil matchup.high_seed_series_wins
      assert_equal 1, matchup.low_seed_series_wins
    end

    def test_all_handles_missing_low_seed_series_w
      response = build_response_without("LOW_SEED_SERIES_W")
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      matchup = PlayoffPicture.all.first

      assert_nil matchup.low_seed_series_wins
      assert_equal 4, matchup.high_seed_series_wins
    end

    def test_all_handles_missing_series_status
      response = build_response_without("SERIES_STATUS")
      stub_request(:get, /playoffpicture/).to_return(body: response.to_json)

      matchup = PlayoffPicture.all.first

      assert_nil matchup.series_status
      assert_equal 1, matchup.low_seed_series_wins
    end

    def test_all_default_league_is_nba
      stub_request(:get, /playoffpicture.*LeagueID=00/)
        .to_return(body: playoff_picture_response.to_json)

      PlayoffPicture.all

      assert_requested :get, /playoffpicture.*LeagueID=00/
    end

    def test_all_default_season_uses_current_season
      current_season_id = Utils.format_season_id(Utils.current_season)
      stub_request(:get, /playoffpicture.*SeasonID=#{current_season_id}/)
        .to_return(body: playoff_picture_response.to_json)

      PlayoffPicture.all

      assert_requested :get, /playoffpicture.*SeasonID=#{current_season_id}/
    end

    private

    def playoff_picture_response
      {resultSets: [{name: "EastConfPlayoffPicture", headers: all_headers, rowSet: [full_row]}]}
    end

    def all_headers
      %w[HIGH_SEED_RANK HIGH_SEED_TEAM HIGH_SEED_TEAM_ID LOW_SEED_RANK
        LOW_SEED_TEAM LOW_SEED_TEAM_ID HIGH_SEED_SERIES_W LOW_SEED_SERIES_W SERIES_STATUS]
    end

    def full_row
      [1, "Boston Celtics", Team::BOS, 8, "Miami Heat", Team::MIA, 4, 1, "Celtics lead 4-1"]
    end

    def build_response_without(excluded_header)
      headers = all_headers.reject { |h| h.eql?(excluded_header) }
      excluded_index = all_headers.index(excluded_header)
      row = full_row.reject.with_index { |_v, i| i.eql?(excluded_index) }
      {resultSets: [{name: "EastConfPlayoffPicture", headers: headers, rowSet: [row]}]}
    end
  end
end
