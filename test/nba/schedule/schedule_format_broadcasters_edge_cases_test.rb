require_relative "../../test_helper"

module NBA
  class ScheduleFormatBroadcastersEdgeCasesTest < Minitest::Test
    cover Schedule

    def test_handles_nil_broadcasters
      game = base_game_data.merge(broadcasters: nil)
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      scheduled_game = Schedule.all.first

      assert_nil scheduled_game.broadcasters
    end

    def test_handles_missing_national_tv_broadcasters_key
      game = base_game_data.merge(broadcasters: {})
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      scheduled_game = Schedule.all.first

      assert_nil scheduled_game.broadcasters
    end

    def test_formats_multiple_broadcasters
      game = base_game_data.merge(broadcasters: {
        nationalTvBroadcasters: [
          {broadcasterDisplay: "TNT"},
          {broadcasterDisplay: "ESPN"}
        ]
      })
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      scheduled_game = Schedule.all.first

      assert_equal "TNT, ESPN", scheduled_game.broadcasters
    end

    def test_handles_broadcaster_with_missing_display
      game = base_game_data.merge(broadcasters: {
        nationalTvBroadcasters: [
          {broadcasterDisplay: "TNT"},
          {}
        ]
      })
      response = {leagueSchedule: {gameDates: [{gameDate: "2024-10-22", games: [game]}]}}
      stub_request(:get, /scheduleleaguev2/).to_return(body: response.to_json)

      scheduled_game = Schedule.all.first

      assert_equal "TNT, ", scheduled_game.broadcasters
    end

    private

    def base_game_data
      {gameDateTimeUTC: "2024-10-22T19:00:00Z", gameId: "0022400001",
       homeTeam: {teamId: Team::GSW, teamName: "Warriors"},
       awayTeam: {teamId: Team::LAL, teamName: "Lakers"}}
    end
  end
end
