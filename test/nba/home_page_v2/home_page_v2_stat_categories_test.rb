require_relative "../../test_helper"

module NBA
  class HomePageV2StatCategoriesTest < Minitest::Test
    cover HomePageV2

    def test_all_extracts_ast_value
      response = {resultSets: [{name: "HomePageStat3",
                                headers: %w[RANK TEAM_ID AST],
                                rowSet: [[1, Team::BOS, 28.5]]}]}
      stub_request(:get, /homepagev2/).to_return(body: response.to_json)

      stat = HomePageV2.all(stat_category: :ast).first

      assert_in_delta 28.5, stat.value
    end

    def test_all_extracts_fg_pct_value
      response = {resultSets: [{name: "HomePageStat5",
                                headers: %w[RANK TEAM_ID FG_PCT],
                                rowSet: [[1, Team::BOS, 0.485]]}]}
      stub_request(:get, /homepagev2/).to_return(body: response.to_json)

      stat = HomePageV2.all(stat_category: :fg_pct).first

      assert_in_delta 0.485, stat.value
    end

    def test_all_extracts_stl_value
      response = {resultSets: [{name: "HomePageStat4",
                                headers: %w[RANK TEAM_ID STL],
                                rowSet: [[1, Team::BOS, 8.5]]}]}
      stub_request(:get, /homepagev2/).to_return(body: response.to_json)

      stat = HomePageV2.all(stat_category: :stl).first

      assert_in_delta 8.5, stat.value
    end

    def test_all_extracts_ft_pct_value
      response = {resultSets: [{name: "HomePageStat6",
                                headers: %w[RANK TEAM_ID FT_PCT],
                                rowSet: [[1, Team::BOS, 0.815]]}]}
      stub_request(:get, /homepagev2/).to_return(body: response.to_json)

      stat = HomePageV2.all(stat_category: :ft_pct).first

      assert_in_delta 0.815, stat.value
    end

    def test_all_extracts_fg3_pct_value
      response = {resultSets: [{name: "HomePageStat7",
                                headers: %w[RANK TEAM_ID FG3_PCT],
                                rowSet: [[1, Team::BOS, 0.385]]}]}
      stub_request(:get, /homepagev2/).to_return(body: response.to_json)

      stat = HomePageV2.all(stat_category: :fg3_pct).first

      assert_in_delta 0.385, stat.value
    end

    def test_all_extracts_blk_value
      response = {resultSets: [{name: "HomePageStat8",
                                headers: %w[RANK TEAM_ID BLK],
                                rowSet: [[1, Team::BOS, 5.5]]}]}
      stub_request(:get, /homepagev2/).to_return(body: response.to_json)

      stat = HomePageV2.all(stat_category: :blk).first

      assert_in_delta 5.5, stat.value
    end
  end
end
