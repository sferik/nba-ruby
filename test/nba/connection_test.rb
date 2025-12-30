require_relative "../test_helper"

module NBA
  class ConnectionTest < Minitest::Test
    cover Connection

    def test_get_makes_http_request
      connection = Connection.new(base_url: "https://stats.nba.com/")
      stub_request(:get, "https://stats.nba.com/teams")
        .to_return(status: 200, body: '{"teams":[]}', headers: {})

      response = connection.get("teams")

      assert_equal '{"teams":[]}', response
    end
  end
end
