require_relative "../../test_helper"

module NBA
  module BoxScoreSummaryV3TestResponseHelpers
    private

    def home_team_data
      {teamId: Team::GSW, teamName: "Warriors", teamCity: "Golden State", teamTricode: "GSW", teamSlug: "warriors",
       teamWins: 1, teamLosses: 0, score: 118, periods: [{period: 1, score: 28}, {period: 2, score: 32},
         {period: 3, score: 25}, {period: 4, score: 33}]}
    end

    def away_team_data
      {teamId: Team::LAL, teamName: "Lakers", teamCity: "Los Angeles", teamTricode: "LAL", teamSlug: "lakers",
       teamWins: 0, teamLosses: 1, score: 109, periods: [{period: 1, score: 25}, {period: 2, score: 28},
         {period: 3, score: 30}, {period: 4, score: 26}]}
    end

    def arena_data
      {arenaId: 10, arenaName: "Chase Center", arenaCity: "San Francisco", arenaState: "CA",
       arenaCountry: "US", arenaTimezone: "America/Los_Angeles"}
    end

    def officials_data
      [{personId: 1, firstName: "Scott", familyName: "Foster", jerseyNum: "48"},
        {personId: 2, firstName: "Tony", familyName: "Brothers", jerseyNum: "25"}]
    end

    def summary_response
      {boxScoreSummary: {gameId: "0022400001", gameCode: "20241022/LALGSW", gameStatus: 3, gameStatusText: "Final",
                         period: 4, gameClock: "PT00M00.00S", gameTimeUTC: "2024-10-23T02:00:00Z",
                         gameEt: "2024-10-22T22:00:00", duration: 138, attendance: 18_064, sellout: "1",
                         arena: arena_data, homeTeam: home_team_data, awayTeam: away_team_data,
                         leadChanges: 12, timesTied: 8, largestLead: 15, officials: officials_data}}
    end

    def stub_summary_request
      stub_request(:get, /boxscoresummaryv3/).to_return(body: summary_response.to_json)
    end
  end

  class BoxScoreSummaryV3FindTest < Minitest::Test
    include BoxScoreSummaryV3TestResponseHelpers

    cover BoxScoreSummaryV3

    def test_find_returns_box_score_summary_v3_data
      stub_summary_request

      assert_instance_of BoxScoreSummaryV3Data, BoxScoreSummaryV3.find(game: "0022400001")
    end

    def test_find_uses_correct_game_id_in_path
      stub_summary_request
      BoxScoreSummaryV3.find(game: "0022400001")

      assert_requested :get, /boxscoresummaryv3\?GameID=0022400001/
    end

    def test_find_parses_summary_successfully
      stub_summary_request
      summary = BoxScoreSummaryV3.find(game: "0022400001")

      assert_equal "0022400001", summary.game_id
    end

    def test_find_parses_home_team_id
      stub_summary_request

      assert_equal Team::GSW, BoxScoreSummaryV3.find(game: "0022400001").home_team_id
    end

    def test_find_parses_away_team_id
      stub_summary_request

      assert_equal Team::LAL, BoxScoreSummaryV3.find(game: "0022400001").away_team_id
    end

    def test_find_parses_home_pts
      stub_summary_request

      assert_equal 118, BoxScoreSummaryV3.find(game: "0022400001").home_pts
    end

    def test_find_parses_away_pts
      stub_summary_request

      assert_equal 109, BoxScoreSummaryV3.find(game: "0022400001").away_pts
    end

    def test_find_parses_officials
      stub_summary_request

      assert_equal ["Scott Foster", "Tony Brothers"], BoxScoreSummaryV3.find(game: "0022400001").officials
    end

    def test_find_accepts_game_object
      stub_summary_request
      BoxScoreSummaryV3.find(game: Game.new(id: "0022400001"))

      assert_requested :get, /GameID=0022400001/
    end

    def test_find_accepts_custom_client
      mock_client = Minitest::Mock.new
      mock_client.expect :get, summary_response.to_json, [String]
      BoxScoreSummaryV3.find(game: "0022400001", client: mock_client)
      mock_client.verify
    end
  end
end
