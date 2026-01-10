require_relative "../test_helper"

module NBA
  class ScheduleInternationalAllTest < Minitest::Test
    cover ScheduleInternational

    def test_all_returns_collection
      stub_schedule_international_request

      assert_instance_of Collection, ScheduleInternational.all
    end

    def test_all_parses_game_info
      stub_schedule_international_request

      game = ScheduleInternational.all.first

      assert_equal "2024-10-22T19:00:00Z", game.game_date
      assert_equal "0022400001", game.game_id
      assert_equal "20241022/LALGSW", game.game_code
      assert_equal 1, game.game_status
      assert_equal "7:00 pm ET", game.game_status_text
    end

    def test_all_parses_home_team_identity
      stub_schedule_international_request

      game = ScheduleInternational.all.first

      assert_equal Team::GSW, game.home_team_id
      assert_equal "Warriors", game.home_team_name
      assert_equal "Golden State", game.home_team_city
      assert_equal "GSW", game.home_team_tricode
    end

    def test_all_parses_home_team_record
      stub_schedule_international_request

      game = ScheduleInternational.all.first

      assert_equal 0, game.home_team_wins
      assert_equal 0, game.home_team_losses
      assert_nil game.home_team_score
    end

    def test_all_parses_away_team_identity
      stub_schedule_international_request

      game = ScheduleInternational.all.first

      assert_equal Team::LAL, game.away_team_id
      assert_equal "Lakers", game.away_team_name
      assert_equal "Los Angeles", game.away_team_city
      assert_equal "LAL", game.away_team_tricode
    end

    def test_all_parses_away_team_record
      stub_schedule_international_request

      game = ScheduleInternational.all.first

      assert_equal 0, game.away_team_wins
      assert_equal 0, game.away_team_losses
      assert_nil game.away_team_score
    end

    def test_all_parses_venue_info
      stub_schedule_international_request

      game = ScheduleInternational.all.first

      assert_equal "Chase Center", game.arena_name
      assert_equal "San Francisco", game.arena_city
      assert_equal "CA", game.arena_state
      assert_equal "TNT", game.broadcasters
    end

    private

    def stub_schedule_international_request
      stub_request(:get, /scheduleleaguev2int/).to_return(body: schedule_international_response.to_json)
    end

    def schedule_international_response
      {leagueSchedule: {gameDates: [{games: [game_data]}]}}
    end

    def game_data
      {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001", gameCode: "20241022/LALGSW",
       gameStatus: 1, gameStatusText: "7:00 pm ET",
       homeTeam: {teamId: Team::GSW, teamName: "Warriors", teamCity: "Golden State",
                  teamTricode: "GSW", wins: 0, losses: 0, score: nil},
       awayTeam: {teamId: Team::LAL, teamName: "Lakers", teamCity: "Los Angeles",
                  teamTricode: "LAL", wins: 0, losses: 0, score: nil},
       arenaName: "Chase Center", arenaCity: "San Francisco", arenaState: "CA",
       broadcasters: {nationalTvBroadcasters: [{broadcasterDisplay: "TNT"}]}}
    end
  end
end
