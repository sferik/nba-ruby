require_relative "../../test_helper"

module NBA
  class ScheduleInternationalEdgeCasesEmptyTest < Minitest::Test
    cover ScheduleInternational

    def test_all_returns_empty_collection_when_response_nil
      client = Minitest::Mock.new
      client.expect(:get, nil, [String])

      result = ScheduleInternational.all(client: client)

      assert_instance_of Collection, result
      assert_empty result
      client.verify
    end

    def test_all_returns_empty_collection_when_response_empty
      stub_request(:get, /scheduleleaguev2int/).to_return(body: "")

      result = ScheduleInternational.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_returns_empty_collection_when_league_schedule_missing
      stub_request(:get, /scheduleleaguev2int/).to_return(body: {}.to_json)

      result = ScheduleInternational.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_returns_empty_collection_when_game_dates_missing
      stub_request(:get, /scheduleleaguev2int/)
        .to_return(body: {leagueSchedule: {}}.to_json)

      result = ScheduleInternational.all

      assert_instance_of Collection, result
      assert_empty result
    end

    def test_all_returns_empty_collection_when_games_missing
      stub_request(:get, /scheduleleaguev2int/)
        .to_return(body: {leagueSchedule: {gameDates: [{}]}}.to_json)

      result = ScheduleInternational.all

      assert_instance_of Collection, result
      assert_empty result
    end
  end
end
