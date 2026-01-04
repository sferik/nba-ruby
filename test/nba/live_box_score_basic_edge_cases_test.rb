require_relative "../test_helper"

module NBA
  class LiveBoxScoreBasicEdgeCasesTest < Minitest::Test
    cover LiveBoxScore

    def test_find_returns_collection
      response = {game: {homeTeam: home_team_data, awayTeam: away_team_data}}
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      assert_instance_of Collection, LiveBoxScore.find(game: "0022400001")
    end

    def test_find_includes_both_teams_players
      response = {game: {homeTeam: home_team_data, awayTeam: away_team_data}}
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stats = LiveBoxScore.find(game: "0022400001")

      assert_equal 2, stats.size
      tricodes = stats.map(&:team_tricode)

      assert_includes tricodes, "GSW"
      assert_includes tricodes, "LAL"
    end

    def test_find_accepts_game_object
      response = {game: {homeTeam: home_team_data, awayTeam: away_team_data}}
      stub_request(:get, /boxscore_0022400001.json/).to_return(body: response.to_json)

      game = Game.new(id: "0022400001")
      LiveBoxScore.find(game: game)

      assert_requested :get, /boxscore_0022400001.json/
    end

    def test_find_returns_empty_collection_when_response_is_nil
      mock_client = Minitest::Mock.new
      mock_client.expect :get, nil, [String]

      assert_equal 0, LiveBoxScore.find(game: "0022400001", client: mock_client).size
      mock_client.verify
    end

    def test_find_returns_empty_collection_when_no_game_data
      stub_request(:get, /cdn.nba.com/).to_return(body: {}.to_json)

      assert_equal 0, LiveBoxScore.find(game: "0022400001").size
    end

    def test_find_sets_game_id_for_home_team_players
      response = {game: {homeTeam: home_team_data, awayTeam: nil}}
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
    end

    def test_find_sets_game_id_for_away_team_players
      response = {game: {homeTeam: nil, awayTeam: away_team_data}}
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stat = LiveBoxScore.find(game: "0022400001").first

      assert_equal "0022400001", stat.game_id
    end

    def test_find_handles_missing_team_key
      response = {game: {homeTeam: home_team_data}}
      stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)

      stats = LiveBoxScore.find(game: "0022400001")

      assert_equal 1, stats.size
    end

    private

    def home_team_data
      {
        teamId: 1_610_612_744,
        teamTricode: "GSW",
        players: [player_data("Stephen", "Curry", 201_939, "30", "G")]
      }
    end

    def away_team_data
      {
        teamId: 1_610_612_747,
        teamTricode: "LAL",
        players: [player_data("LeBron", "James", 2544, "23", "F")]
      }
    end

    def player_data(first_name, last_name, id, jersey, position)
      {
        personId: id,
        name: "#{first_name} #{last_name}",
        firstName: first_name,
        familyName: last_name,
        jerseyNum: jersey,
        position: position,
        starter: "1",
        statistics: {minutes: "PT36M00.00S", points: 30, reboundsTotal: 5, assists: 8}
      }
    end
  end
end
