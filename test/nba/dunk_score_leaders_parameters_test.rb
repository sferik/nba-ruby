require_relative "../test_helper"

module NBA
  class DunkScoreLeadersSeasonParametersTest < Minitest::Test
    cover DunkScoreLeaders

    def test_all_with_custom_season
      stub_request(:get, /dunkscoreleaders.*Season=2022-23/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all(season: 2022)

      assert_requested :get, /dunkscoreleaders.*Season=2022-23/
    end

    def test_all_with_playoffs_season_type
      stub_request(:get, /dunkscoreleaders.*SeasonType=Playoffs/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all(season_type: "Playoffs")

      assert_requested :get, /dunkscoreleaders.*SeasonType=Playoffs/
    end

    def test_all_default_season_type_is_regular_season
      stub_request(:get, /dunkscoreleaders.*SeasonType=Regular%20Season/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all

      assert_requested :get, /dunkscoreleaders.*SeasonType=Regular%20Season/
    end

    private

    def dunk_score_leaders_response
      {resultSets: [{name: "DunkScoreLeaders",
                     headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION DUNK_SCORE],
                     rowSet: [[1, 1_631_094, "Paolo Banchero", Team::ORL, "ORL", 85.5]]}]}
    end
  end

  class DunkScoreLeadersFilterParametersTest < Minitest::Test
    cover DunkScoreLeaders

    def test_all_with_player_filter
      stub_request(:get, /dunkscoreleaders.*PlayerID=1631094/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all(player: 1_631_094)

      assert_requested :get, /dunkscoreleaders.*PlayerID=1631094/
    end

    def test_all_with_team_filter
      stub_request(:get, /dunkscoreleaders.*TeamID=#{Team::ORL}/o)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all(team: Team::ORL)

      assert_requested :get, /dunkscoreleaders.*TeamID=#{Team::ORL}/o
    end

    def test_all_with_game_filter
      stub_request(:get, /dunkscoreleaders.*GameID=0022300001/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all(game: "0022300001")

      assert_requested :get, /dunkscoreleaders.*GameID=0022300001/
    end

    def test_all_with_player_object
      player = Player.new(id: 1_631_094)
      stub_request(:get, /dunkscoreleaders.*PlayerID=1631094/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all(player: player)

      assert_requested :get, /dunkscoreleaders.*PlayerID=1631094/
    end

    def test_all_with_team_object
      team = Team.new(id: Team::ORL)
      stub_request(:get, /dunkscoreleaders.*TeamID=#{Team::ORL}/o)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all(team: team)

      assert_requested :get, /dunkscoreleaders.*TeamID=#{Team::ORL}/o
    end

    def test_all_with_game_object
      game = Game.new(id: "0022300001")
      stub_request(:get, /dunkscoreleaders.*GameID=0022300001/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all(game: game)

      assert_requested :get, /dunkscoreleaders.*GameID=0022300001/
    end

    def test_all_without_player_sends_empty_player_id_not_nil
      stub_request(:get, /dunkscoreleaders/)
        .with { |request| request.uri.query.include?("PlayerID=&") }
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all

      assert_requested :get, /dunkscoreleaders/
    end

    def test_all_without_team_sends_empty_team_id_not_nil
      stub_request(:get, /dunkscoreleaders/)
        .with { |request| request.uri.query.end_with?("TeamID=") }
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all

      assert_requested :get, /dunkscoreleaders/
    end

    def test_all_without_game_sends_empty_game_id_not_nil
      stub_request(:get, /dunkscoreleaders/)
        .with { |request| request.uri.query.include?("GameID=&") }
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all

      assert_requested :get, /dunkscoreleaders/
    end

    private

    def dunk_score_leaders_response
      {resultSets: [{name: "DunkScoreLeaders",
                     headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION DUNK_SCORE],
                     rowSet: [[1, 1_631_094, "Paolo Banchero", Team::ORL, "ORL", 85.5]]}]}
    end
  end

  class DunkScoreLeadersLeagueParametersTest < Minitest::Test
    cover DunkScoreLeaders

    def test_all_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /dunkscoreleaders.*LeagueID=00/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all(league: league)

      assert_requested :get, /dunkscoreleaders.*LeagueID=00/
    end

    def test_all_with_league_string
      stub_request(:get, /dunkscoreleaders.*LeagueID=00/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all(league: "00")

      assert_requested :get, /dunkscoreleaders.*LeagueID=00/
    end

    def test_all_default_league_is_nba
      stub_request(:get, /dunkscoreleaders.*LeagueID=00/)
        .to_return(body: dunk_score_leaders_response.to_json)

      DunkScoreLeaders.all

      assert_requested :get, /dunkscoreleaders.*LeagueID=00/
    end

    private

    def dunk_score_leaders_response
      {resultSets: [{name: "DunkScoreLeaders",
                     headers: %w[RANK PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION DUNK_SCORE],
                     rowSet: [[1, 1_631_094, "Paolo Banchero", Team::ORL, "ORL", 85.5]]}]}
    end
  end
end
