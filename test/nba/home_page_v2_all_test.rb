require_relative "../test_helper"

module NBA
  class HomePageV2AllTest < Minitest::Test
    cover HomePageV2

    def test_all_returns_collection
      stub_home_page_v2_request

      assert_instance_of Collection, HomePageV2.all(stat_category: :pts)
    end

    def test_all_parses_rank
      stub_home_page_v2_request

      stat = HomePageV2.all(stat_category: :pts).first

      assert_equal 1, stat.rank
    end

    def test_all_parses_team_info
      stub_home_page_v2_request

      stat = HomePageV2.all(stat_category: :pts).first

      assert_equal Team::BOS, stat.team_id
      assert_equal "BOS", stat.team_abbreviation
      assert_equal "Boston Celtics", stat.team_name
    end

    def test_all_parses_pts_value
      stub_home_page_v2_request

      stat = HomePageV2.all(stat_category: :pts).first

      assert_in_delta 120.5, stat.value
    end

    def test_all_sets_stat_name
      stub_home_page_v2_request

      stat = HomePageV2.all(stat_category: :pts).first

      assert_equal "pts", stat.stat_name
    end

    def test_all_with_reb_category
      stub_request(:get, /homepagev2/).to_return(body: reb_response.to_json)

      stat = HomePageV2.all(stat_category: :reb).first

      assert_in_delta 48.5, stat.value
      assert_equal "reb", stat.stat_name
    end

    def test_all_stat_name_is_string
      stub_home_page_v2_request

      stat = HomePageV2.all(stat_category: :pts).first

      assert_instance_of String, stat.stat_name
      refute_instance_of Symbol, stat.stat_name
    end

    private

    def stub_home_page_v2_request
      stub_request(:get, /homepagev2/).to_return(body: home_page_v2_response.to_json)
    end

    def home_page_v2_response
      {resultSets: [{name: "HomePageStat1",
                     headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME PTS],
                     rowSet: [[1, Team::BOS, "BOS", "Boston Celtics", 120.5]]}]}
    end

    def reb_response
      {resultSets: [{name: "HomePageStat2",
                     headers: %w[RANK TEAM_ID TEAM_ABBREVIATION TEAM_NAME REB],
                     rowSet: [[1, Team::BOS, "BOS", "Boston Celtics", 48.5]]}]}
    end
  end
end
