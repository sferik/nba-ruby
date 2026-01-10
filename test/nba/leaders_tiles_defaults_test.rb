require_relative "../test_helper"

module NBA
  class LeadersTilesDefaultsTest < Minitest::Test
    cover LeadersTiles

    def test_all_with_game_scope
      stub_request(:get, /leaderstiles.*GameScope=Yesterday/)
        .to_return(body: leaders_tiles_response.to_json)

      LeadersTiles.all(game_scope: "Yesterday")

      assert_requested :get, /leaderstiles.*GameScope=Yesterday/
    end

    def test_all_with_player_or_team
      stub_request(:get, /leaderstiles.*PlayerOrTeam=Player/)
        .to_return(body: leaders_tiles_response.to_json)

      LeadersTiles.all(player_or_team: "Player")

      assert_requested :get, /leaderstiles.*PlayerOrTeam=Player/
    end

    def test_all_with_player_scope
      stub_request(:get, /leaderstiles.*PlayerScope=Rookies/)
        .to_return(body: leaders_tiles_response.to_json)

      LeadersTiles.all(player_scope: "Rookies")

      assert_requested :get, /leaderstiles.*PlayerScope=Rookies/
    end

    def test_all_default_season_type_is_regular_season
      stub_request(:get, /leaderstiles.*SeasonType=Regular%20Season/)
        .to_return(body: leaders_tiles_response.to_json)

      LeadersTiles.all

      assert_requested :get, /leaderstiles.*SeasonType=Regular%20Season/
    end

    def test_all_default_game_scope_is_season
      stub_request(:get, /leaderstiles.*GameScope=Season/)
        .to_return(body: leaders_tiles_response.to_json)

      LeadersTiles.all

      assert_requested :get, /leaderstiles.*GameScope=Season/
    end

    def test_all_default_player_or_team_is_team
      stub_request(:get, /leaderstiles.*PlayerOrTeam=Team/)
        .to_return(body: leaders_tiles_response.to_json)

      LeadersTiles.all

      assert_requested :get, /leaderstiles.*PlayerOrTeam=Team/
    end

    def test_all_default_player_scope_is_all_players
      stub_request(:get, /leaderstiles.*PlayerScope=All%20Players/)
        .to_return(body: leaders_tiles_response.to_json)

      LeadersTiles.all

      assert_requested :get, /leaderstiles.*PlayerScope=All%20Players/
    end

    def test_all_default_stat_is_pts
      stub_request(:get, /leaderstiles.*Stat=PTS/)
        .to_return(body: leaders_tiles_response.to_json)

      LeadersTiles.all

      assert_requested :get, /leaderstiles.*Stat=PTS/
    end

    def test_all_default_league_is_nba
      stub_request(:get, /leaderstiles.*LeagueID=00/)
        .to_return(body: leaders_tiles_response.to_json)

      LeadersTiles.all

      assert_requested :get, /leaderstiles.*LeagueID=00/
    end

    private

    def leaders_tiles_response
      {resultSets: [{name: "LeadersTiles",
                     headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME PTS],
                     rowSet: [[1, Team::BOS, "BOS", "Boston Celtics", 120.5]]}]}
    end
  end
end
