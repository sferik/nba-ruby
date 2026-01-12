require_relative "../../test_helper"

module NBA
  class ConnectionHeadersTest < Minitest::Test
    cover Connection

    def test_get_sets_user_agent_header
      stub_stats_request
      Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_requested(:get, "https://stats.nba.com/teams", headers: {"User-Agent" => /Mozilla/})
    end

    def test_get_sets_accept_header
      stub_stats_request
      Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_requested(:get, "https://stats.nba.com/teams", headers: {"Accept" => %r{application/json}})
    end

    def test_get_sets_referer_header
      stub_stats_request
      Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_requested(:get, "https://stats.nba.com/teams", headers: {"Referer" => "https://www.nba.com/"})
    end

    def test_get_sets_accept_language_header
      stub_stats_request
      Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_requested(:get, "https://stats.nba.com/teams", headers: {"Accept-Language" => "en-US,en;q=0.9"})
    end

    def test_get_sets_accept_encoding_header
      stub_stats_request
      Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_requested(:get, "https://stats.nba.com/teams", headers: {"Accept-Encoding" => "gzip, deflate, identity"})
    end

    def test_get_sets_connection_header
      stub_stats_request
      Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_requested(:get, "https://stats.nba.com/teams", headers: {"Connection" => "keep-alive"})
    end

    def test_get_sets_origin_header
      stub_stats_request
      Connection.new(base_url: "https://stats.nba.com/").get("teams")

      assert_requested(:get, "https://stats.nba.com/teams", headers: {"Origin" => "https://www.nba.com"})
    end

    private

    def stub_stats_request
      stub_request(:get, "https://stats.nba.com/teams").to_return(status: 200, body: "{}", headers: {})
    end
  end
end
