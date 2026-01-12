require_relative "../../test_helper"

module NBA
  class LeagueSeasonMatchupsEdgeCasesTest < Minitest::Test
    cover LeagueSeasonMatchups

    def test_all_handles_missing_matchup_fg3_pct
      result = matchups_without("MATCHUP_FG3_PCT")

      assert_nil result.first.matchup_fg3_pct
    end

    def test_all_handles_missing_help_blk
      result = matchups_without("HELP_BLK")

      assert_nil result.first.help_blk
    end

    def test_all_handles_missing_help_fgm
      result = matchups_without("HELP_FGM")

      assert_nil result.first.help_fgm
    end

    def test_all_handles_missing_help_fga
      result = matchups_without("HELP_FGA")

      assert_nil result.first.help_fga
    end

    def test_all_handles_missing_help_fg_perc
      result = matchups_without("HELP_FG_PERC")

      assert_nil result.first.help_fg_pct
    end

    def test_all_handles_missing_matchup_ftm
      result = matchups_without("MATCHUP_FTM")

      assert_nil result.first.matchup_ftm
    end

    def test_all_handles_missing_matchup_fta
      result = matchups_without("MATCHUP_FTA")

      assert_nil result.first.matchup_fta
    end

    def test_all_handles_missing_sfl
      result = matchups_without("SFL")

      assert_nil result.first.sfl
    end

    def test_all_returns_empty_collection_for_empty_response
      stub_request(:get, /leagueseasonmatchups/).to_return(body: "")

      assert_empty LeagueSeasonMatchups.all(season: 2024)
    end

    def test_all_returns_empty_collection_for_nil_response
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      result = LeagueSeasonMatchups.all(season: 2024, client: mock_client)

      assert_empty result
      mock_client.verify
    end

    def test_all_returns_empty_collection_for_missing_result_sets
      stub_request(:get, /leagueseasonmatchups/).to_return(body: {}.to_json)

      assert_empty LeagueSeasonMatchups.all(season: 2024)
    end

    def test_all_returns_empty_collection_for_wrong_result_set_name
      response = {resultSets: [{name: "WrongName", headers: stat_headers, rowSet: [stat_row]}]}
      stub_request(:get, /leagueseasonmatchups/).to_return(body: response.to_json)

      assert_empty LeagueSeasonMatchups.all(season: 2024)
    end

    def test_all_returns_empty_collection_for_missing_headers
      response = {resultSets: [{name: "SeasonMatchups", rowSet: [stat_row]}]}
      stub_request(:get, /leagueseasonmatchups/).to_return(body: response.to_json)

      assert_empty LeagueSeasonMatchups.all(season: 2024)
    end

    def test_all_returns_empty_collection_for_missing_row_set
      response = {resultSets: [{name: "SeasonMatchups", headers: stat_headers}]}
      stub_request(:get, /leagueseasonmatchups/).to_return(body: response.to_json)

      assert_empty LeagueSeasonMatchups.all(season: 2024)
    end

    def test_all_handles_result_set_with_missing_name_key
      response = {resultSets: [{headers: stat_headers, rowSet: [stat_row]}]}
      stub_request(:get, /leagueseasonmatchups/).to_return(body: response.to_json)

      assert_empty LeagueSeasonMatchups.all(season: 2024)
    end

    private

    def matchups_without(header)
      headers = stat_headers.reject { |h| h.eql?(header) }
      row = build_row_without(header)
      response = {resultSets: [{name: "SeasonMatchups", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leagueseasonmatchups/).to_return(body: response.to_json)

      LeagueSeasonMatchups.all(season: 2024)
    end

    def matchups_response
      {resultSets: [{name: "SeasonMatchups", headers: stat_headers, rowSet: [stat_row]}]}
    end

    def stat_headers
      %w[SEASON_ID OFF_PLAYER_ID OFF_PLAYER_NAME DEF_PLAYER_ID DEF_PLAYER_NAME GP
        MATCHUP_MIN PARTIAL_POSS PLAYER_PTS TEAM_PTS MATCHUP_AST MATCHUP_TOV MATCHUP_BLK
        MATCHUP_FGM MATCHUP_FGA MATCHUP_FG_PCT MATCHUP_FG3M MATCHUP_FG3A MATCHUP_FG3_PCT
        HELP_BLK HELP_FGM HELP_FGA HELP_FG_PERC MATCHUP_FTM MATCHUP_FTA SFL]
    end

    def stat_row
      ["22024", 201_939, "Stephen Curry", 203_507, "Giannis Antetokounmpo", 4,
        12.5, 45.2, 18.0, 22.0, 3.0, 1.0, 0.5,
        6.0, 14.0, 0.429, 2.0, 6.0, 0.333,
        0.0, 1.0, 2.0, 0.500, 4.0, 5.0, 2.0]
    end

    def build_row_without(header)
      idx = stat_headers.index(header)
      stat_row.reject.with_index { |_, i| i.eql?(idx) }
    end
  end
end
