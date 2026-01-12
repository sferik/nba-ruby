require_relative "../../test_helper"

module NBA
  class DefenseHubAllTest < Minitest::Test
    cover DefenseHub

    def test_all_returns_collection
      stub_defense_hub_request

      assert_instance_of Collection, DefenseHub.all(stat_category: :dreb)
    end

    def test_all_parses_rank
      stub_defense_hub_request

      stat = DefenseHub.all(stat_category: :dreb).first

      assert_equal 1, stat.rank
    end

    def test_all_parses_team_info
      stub_defense_hub_request

      stat = DefenseHub.all(stat_category: :dreb).first

      assert_equal Team::BOS, stat.team_id
      assert_equal "BOS", stat.team_abbreviation
      assert_equal "Boston Celtics", stat.team_name
    end

    def test_all_parses_dreb_value
      stub_defense_hub_request

      stat = DefenseHub.all(stat_category: :dreb).first

      assert_in_delta 47.8, stat.value
    end

    def test_all_sets_stat_name
      stub_defense_hub_request

      stat = DefenseHub.all(stat_category: :dreb).first

      assert_equal "dreb", stat.stat_name
    end

    def test_all_with_stl_category
      stub_request(:get, /defensehub/).to_return(body: stl_response.to_json)

      stat = DefenseHub.all(stat_category: :stl).first

      assert_in_delta 8.5, stat.value
      assert_equal "stl", stat.stat_name
    end

    def test_all_with_custom_season
      stub_request(:get, /defensehub.*Season=2022-23/)
        .to_return(body: defense_hub_response.to_json)

      DefenseHub.all(stat_category: :dreb, season: 2022)

      assert_requested :get, /defensehub.*Season=2022-23/
    end

    def test_all_with_playoffs_season_type
      stub_request(:get, /defensehub.*SeasonType=Playoffs/)
        .to_return(body: defense_hub_response.to_json)

      DefenseHub.all(stat_category: :dreb, season_type: "Playoffs")

      assert_requested :get, /defensehub.*SeasonType=Playoffs/
    end

    def test_all_with_league_object
      league = League.new(id: "00")
      stub_request(:get, /defensehub.*LeagueID=00/)
        .to_return(body: defense_hub_response.to_json)

      DefenseHub.all(stat_category: :dreb, league: league)

      assert_requested :get, /defensehub.*LeagueID=00/
    end

    def test_all_with_league_string
      stub_request(:get, /defensehub.*LeagueID=00/)
        .to_return(body: defense_hub_response.to_json)

      DefenseHub.all(stat_category: :dreb, league: "00")

      assert_requested :get, /defensehub.*LeagueID=00/
    end

    def test_all_with_game_scope
      stub_request(:get, /defensehub.*GameScope=Yesterday/)
        .to_return(body: defense_hub_response.to_json)

      DefenseHub.all(stat_category: :dreb, game_scope: "Yesterday")

      assert_requested :get, /defensehub.*GameScope=Yesterday/
    end

    def test_all_with_player_or_team
      stub_request(:get, /defensehub.*PlayerOrTeam=Player/)
        .to_return(body: defense_hub_response.to_json)

      DefenseHub.all(stat_category: :dreb, player_or_team: "Player")

      assert_requested :get, /defensehub.*PlayerOrTeam=Player/
    end

    def test_all_with_player_scope
      stub_request(:get, /defensehub.*PlayerScope=Rookies/)
        .to_return(body: defense_hub_response.to_json)

      DefenseHub.all(stat_category: :dreb, player_scope: "Rookies")

      assert_requested :get, /defensehub.*PlayerScope=Rookies/
    end

    private

    def stub_defense_hub_request
      stub_request(:get, /defensehub/).to_return(body: defense_hub_response.to_json)
    end

    def defense_hub_response
      {resultSets: [{name: "DefenseHubStat1",
                     headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME DREB],
                     rowSet: [[1, Team::BOS, "BOS", "Boston Celtics", 47.8]]}]}
    end

    def stl_response
      {resultSets: [{name: "DefenseHubStat2",
                     headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME STL],
                     rowSet: [[1, Team::BOS, "BOS", "Boston Celtics", 8.5]]}]}
    end
  end
end
