require_relative "../test_helper"

module NBA
  class AssistTrackerMissingPlayerKeysTest < Minitest::Test
    cover AssistTracker

    def test_all_handles_missing_player_id
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_NAME TEAM_ID TEAM_ABBREVIATION PASS_TO],
                                rowSet: [["Russell Westbrook", Team::LAC, "LAC", "Kawhi Leonard"]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_nil entry.player_id
      assert_equal "Russell Westbrook", entry.player_name
    end

    def test_all_handles_missing_player_name
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID TEAM_ID TEAM_ABBREVIATION PASS_TO],
                                rowSet: [[201_566, Team::LAC, "LAC", "Kawhi Leonard"]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 201_566, entry.player_id
      assert_nil entry.player_name
    end

    def test_all_handles_missing_team_id
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME TEAM_ABBREVIATION PASS_TO],
                                rowSet: [[201_566, "Russell Westbrook", "LAC", "Kawhi Leonard"]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_nil entry.team_id
      assert_equal "LAC", entry.team_abbreviation
    end

    def test_all_handles_missing_team_abbreviation
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME TEAM_ID PASS_TO],
                                rowSet: [[201_566, "Russell Westbrook", Team::LAC, "Kawhi Leonard"]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal Team::LAC, entry.team_id
      assert_nil entry.team_abbreviation
    end
  end

  class AssistTrackerMissingPassKeysTest < Minitest::Test
    cover AssistTracker

    def test_all_handles_missing_pass_to
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION],
                                rowSet: [[201_566, "Russell Westbrook", Team::LAC, "LAC"]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 201_566, entry.player_id
      assert_nil entry.pass_to
    end

    def test_all_handles_missing_pass_to_player_id
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION PASS_TO],
                                rowSet: [[201_566, "Russell Westbrook", Team::LAC, "LAC", "Kawhi Leonard"]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal "Kawhi Leonard", entry.pass_to
      assert_nil entry.pass_to_player_id
    end

    def test_all_handles_missing_frequency
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME AST],
                                rowSet: [[201_566, "Russell Westbrook", 32]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_nil entry.frequency
      assert_equal 32, entry.ast
    end

    def test_all_handles_missing_pass
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME AST],
                                rowSet: [[201_566, "Russell Westbrook", 32]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_nil entry.pass
      assert_equal 32, entry.ast
    end

    def test_all_handles_missing_ast
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME PASS],
                                rowSet: [[201_566, "Russell Westbrook", 45]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 45, entry.pass
      assert_nil entry.ast
    end
  end

  class AssistTrackerMissingFgKeysTest < Minitest::Test
    cover AssistTracker

    def test_all_handles_missing_fg_m
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FGA FG_PCT],
                                rowSet: [[201_566, "Russell Westbrook", 45, 0.622]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_nil entry.fg_m
      assert_equal 45, entry.fg_a
    end

    def test_all_handles_missing_fg_a
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FGM FG_PCT],
                                rowSet: [[201_566, "Russell Westbrook", 28, 0.622]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 28, entry.fg_m
      assert_nil entry.fg_a
    end

    def test_all_handles_missing_fg_pct
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FGM FGA],
                                rowSet: [[201_566, "Russell Westbrook", 28, 45]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 28, entry.fg_m
      assert_nil entry.fg_pct
    end
  end

  class AssistTrackerMissingFg2KeysTest < Minitest::Test
    cover AssistTracker

    def test_all_handles_missing_fg2m
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FG2A FG2_PCT],
                                rowSet: [[201_566, "Russell Westbrook", 30, 0.667]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_nil entry.fg2m
      assert_equal 30, entry.fg2a
    end

    def test_all_handles_missing_fg2a
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FG2M FG2_PCT],
                                rowSet: [[201_566, "Russell Westbrook", 20, 0.667]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 20, entry.fg2m
      assert_nil entry.fg2a
    end

    def test_all_handles_missing_fg2_pct
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FG2M FG2A],
                                rowSet: [[201_566, "Russell Westbrook", 20, 30]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 20, entry.fg2m
      assert_nil entry.fg2_pct
    end
  end

  class AssistTrackerMissingFg3KeysTest < Minitest::Test
    cover AssistTracker

    def test_all_handles_missing_fg3m
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FG3A FG3_PCT],
                                rowSet: [[201_566, "Russell Westbrook", 15, 0.533]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_nil entry.fg3m
      assert_equal 15, entry.fg3a
    end

    def test_all_handles_missing_fg3a
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FG3M FG3_PCT],
                                rowSet: [[201_566, "Russell Westbrook", 8, 0.533]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 8, entry.fg3m
      assert_nil entry.fg3a
    end

    def test_all_handles_missing_fg3_pct
      response = {resultSets: [{name: "AssistTracker",
                                headers: %w[PLAYER_ID PLAYER_NAME FG3M FG3A],
                                rowSet: [[201_566, "Russell Westbrook", 8, 15]]}]}
      stub_request(:get, /assisttracker/).to_return(body: response.to_json)

      entry = AssistTracker.all.first

      assert_equal 8, entry.fg3m
      assert_nil entry.fg3_pct
    end
  end
end
