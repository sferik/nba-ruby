require_relative "../test_helper"

module NBA
  # rubocop:disable Metrics/ClassLength
  class LeagueHustleStatsNilHandlingTest < Minitest::Test
    cover LeagueHustleStats

    # Player identity attributes
    def test_player_stats_nil_for_missing_player_id
      stat = player_stat_without("PLAYER_ID")

      assert_nil stat.player_id
    end

    def test_player_stats_nil_for_missing_player_name
      stat = player_stat_without("PLAYER_NAME")

      assert_nil stat.player_name
    end

    def test_player_stats_nil_for_missing_team_id
      stat = player_stat_without("TEAM_ID")

      assert_nil stat.team_id
    end

    def test_player_stats_nil_for_missing_team_abbreviation
      stat = player_stat_without("TEAM_ABBREVIATION")

      assert_nil stat.team_abbreviation
    end

    def test_player_stats_nil_for_missing_age
      stat = player_stat_without("AGE")

      assert_nil stat.age
    end

    # Player game stats
    def test_player_stats_nil_for_missing_gp
      stat = player_stat_without("G")

      assert_nil stat.gp
    end

    def test_player_stats_nil_for_missing_w
      stat = player_stat_without("W")

      assert_nil stat.w
    end

    def test_player_stats_nil_for_missing_l
      stat = player_stat_without("L")

      assert_nil stat.l
    end

    def test_player_stats_nil_for_missing_min
      stat = player_stat_without("MIN")

      assert_nil stat.min
    end

    # Player hustle stats - contested shots
    def test_player_stats_nil_for_missing_contested_shots
      stat = player_stat_without("CONTESTED_SHOTS")

      assert_nil stat.contested_shots
    end

    def test_player_stats_nil_for_missing_contested_shots_2pt
      stat = player_stat_without("CONTESTED_SHOTS_2PT")

      assert_nil stat.contested_shots_2pt
    end

    def test_player_stats_nil_for_missing_contested_shots_3pt
      stat = player_stat_without("CONTESTED_SHOTS_3PT")

      assert_nil stat.contested_shots_3pt
    end

    # Player hustle stats - deflections and charges
    def test_player_stats_nil_for_missing_deflections
      stat = player_stat_without("DEFLECTIONS")

      assert_nil stat.deflections
    end

    def test_player_stats_nil_for_missing_charges_drawn
      stat = player_stat_without("CHARGES_DRAWN")

      assert_nil stat.charges_drawn
    end

    # Player hustle stats - screen assists
    def test_player_stats_nil_for_missing_screen_assists
      stat = player_stat_without("SCREEN_ASSISTS")

      assert_nil stat.screen_assists
    end

    def test_player_stats_nil_for_missing_screen_ast_pts
      stat = player_stat_without("SCREEN_AST_PTS")

      assert_nil stat.screen_ast_pts
    end

    # Player hustle stats - loose balls
    def test_player_stats_nil_for_missing_loose_balls_recovered
      stat = player_stat_without("LOOSE_BALLS_RECOVERED")

      assert_nil stat.loose_balls_recovered
    end

    def test_player_stats_nil_for_missing_off_loose_balls_recovered
      stat = player_stat_without("OFF_LOOSE_BALLS_RECOVERED")

      assert_nil stat.off_loose_balls_recovered
    end

    def test_player_stats_nil_for_missing_def_loose_balls_recovered
      stat = player_stat_without("DEF_LOOSE_BALLS_RECOVERED")

      assert_nil stat.def_loose_balls_recovered
    end

    # Player hustle stats - box outs
    def test_player_stats_nil_for_missing_box_outs
      stat = player_stat_without("BOX_OUTS")

      assert_nil stat.box_outs
    end

    def test_player_stats_nil_for_missing_off_box_outs
      stat = player_stat_without("OFF_BOX_OUTS")

      assert_nil stat.off_box_outs
    end

    def test_player_stats_nil_for_missing_def_box_outs
      stat = player_stat_without("DEF_BOX_OUTS")

      assert_nil stat.def_box_outs
    end

    # Team identity attributes
    def test_team_stats_nil_for_missing_team_id
      stat = team_stat_without("TEAM_ID")

      assert_nil stat.team_id
    end

    def test_team_stats_nil_for_missing_team_name
      stat = team_stat_without("TEAM_NAME")

      assert_nil stat.team_name
    end

    # Team game stats
    def test_team_stats_nil_for_missing_gp
      stat = team_stat_without("G")

      assert_nil stat.gp
    end

    def test_team_stats_nil_for_missing_w
      stat = team_stat_without("W")

      assert_nil stat.w
    end

    def test_team_stats_nil_for_missing_l
      stat = team_stat_without("L")

      assert_nil stat.l
    end

    def test_team_stats_nil_for_missing_min
      stat = team_stat_without("MIN")

      assert_nil stat.min
    end

    # Team hustle stats - contested shots
    def test_team_stats_nil_for_missing_contested_shots
      stat = team_stat_without("CONTESTED_SHOTS")

      assert_nil stat.contested_shots
    end

    def test_team_stats_nil_for_missing_contested_shots_2pt
      stat = team_stat_without("CONTESTED_SHOTS_2PT")

      assert_nil stat.contested_shots_2pt
    end

    def test_team_stats_nil_for_missing_contested_shots_3pt
      stat = team_stat_without("CONTESTED_SHOTS_3PT")

      assert_nil stat.contested_shots_3pt
    end

    # Team hustle stats - deflections and charges
    def test_team_stats_nil_for_missing_deflections
      stat = team_stat_without("DEFLECTIONS")

      assert_nil stat.deflections
    end

    def test_team_stats_nil_for_missing_charges_drawn
      stat = team_stat_without("CHARGES_DRAWN")

      assert_nil stat.charges_drawn
    end

    # Team hustle stats - screen assists
    def test_team_stats_nil_for_missing_screen_assists
      stat = team_stat_without("SCREEN_ASSISTS")

      assert_nil stat.screen_assists
    end

    def test_team_stats_nil_for_missing_screen_ast_pts
      stat = team_stat_without("SCREEN_AST_PTS")

      assert_nil stat.screen_ast_pts
    end

    # Team hustle stats - loose balls
    def test_team_stats_nil_for_missing_loose_balls_recovered
      stat = team_stat_without("LOOSE_BALLS_RECOVERED")

      assert_nil stat.loose_balls_recovered
    end

    def test_team_stats_nil_for_missing_off_loose_balls_recovered
      stat = team_stat_without("OFF_LOOSE_BALLS_RECOVERED")

      assert_nil stat.off_loose_balls_recovered
    end

    def test_team_stats_nil_for_missing_def_loose_balls_recovered
      stat = team_stat_without("DEF_LOOSE_BALLS_RECOVERED")

      assert_nil stat.def_loose_balls_recovered
    end

    # Team hustle stats - box outs
    def test_team_stats_nil_for_missing_box_outs
      stat = team_stat_without("BOX_OUTS")

      assert_nil stat.box_outs
    end

    def test_team_stats_nil_for_missing_off_box_outs
      stat = team_stat_without("OFF_BOX_OUTS")

      assert_nil stat.off_box_outs
    end

    def test_team_stats_nil_for_missing_def_box_outs
      stat = team_stat_without("DEF_BOX_OUTS")

      assert_nil stat.def_box_outs
    end

    private

    def player_stat_without(key)
      headers = all_player_headers.reject { |h| h == key }
      row = build_player_row_without(key)
      response = {resultSets: [{name: "HustleStatsPlayer", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguehustlestatsplayer/).to_return(body: response.to_json)
      LeagueHustleStats.player_stats.first
    end

    def team_stat_without(key)
      headers = all_team_headers.reject { |h| h == key }
      row = build_team_row_without(key)
      response = {resultSets: [{name: "HustleStatsTeam", headers: headers, rowSet: [row]}]}
      stub_request(:get, /leaguehustlestatsteam/).to_return(body: response.to_json)
      LeagueHustleStats.team_stats.first
    end

    def all_player_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE G W L MIN CONTESTED_SHOTS
        CONTESTED_SHOTS_2PT CONTESTED_SHOTS_3PT DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS
        SCREEN_AST_PTS LOOSE_BALLS_RECOVERED OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED
        BOX_OUTS OFF_BOX_OUTS DEF_BOX_OUTS]
    end

    def all_team_headers
      %w[TEAM_ID TEAM_NAME G W L MIN CONTESTED_SHOTS CONTESTED_SHOTS_2PT
        CONTESTED_SHOTS_3PT DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS SCREEN_AST_PTS
        LOOSE_BALLS_RECOVERED OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED BOX_OUTS
        OFF_BOX_OUTS DEF_BOX_OUTS]
    end

    # rubocop:disable Metrics/MethodLength
    def build_player_row_without(excluded_key)
      row_data = {
        "PLAYER_ID" => 201_939,
        "PLAYER_NAME" => "Stephen Curry",
        "TEAM_ID" => Team::GSW,
        "TEAM_ABBREVIATION" => "GSW",
        "AGE" => 36,
        "G" => 82,
        "W" => 50,
        "L" => 32,
        "MIN" => 34.5,
        "CONTESTED_SHOTS" => 5.5,
        "CONTESTED_SHOTS_2PT" => 3.5,
        "CONTESTED_SHOTS_3PT" => 2.0,
        "DEFLECTIONS" => 2.5,
        "CHARGES_DRAWN" => 0.2,
        "SCREEN_ASSISTS" => 3.0,
        "SCREEN_AST_PTS" => 7.5,
        "LOOSE_BALLS_RECOVERED" => 1.0,
        "OFF_LOOSE_BALLS_RECOVERED" => 0.5,
        "DEF_LOOSE_BALLS_RECOVERED" => 0.5,
        "BOX_OUTS" => 2.0,
        "OFF_BOX_OUTS" => 0.5,
        "DEF_BOX_OUTS" => 1.5
      }
      all_player_headers.reject { |h| h == excluded_key }.map { |h| row_data[h] }
    end
    # rubocop:enable Metrics/MethodLength

    # rubocop:disable Metrics/MethodLength
    def build_team_row_without(excluded_key)
      row_data = {
        "TEAM_ID" => Team::GSW,
        "TEAM_NAME" => "Warriors",
        "G" => 82,
        "W" => 50,
        "L" => 32,
        "MIN" => 48.0,
        "CONTESTED_SHOTS" => 55.0,
        "CONTESTED_SHOTS_2PT" => 35.0,
        "CONTESTED_SHOTS_3PT" => 20.0,
        "DEFLECTIONS" => 15.0,
        "CHARGES_DRAWN" => 1.5,
        "SCREEN_ASSISTS" => 18.0,
        "SCREEN_AST_PTS" => 45.0,
        "LOOSE_BALLS_RECOVERED" => 6.5,
        "OFF_LOOSE_BALLS_RECOVERED" => 3.0,
        "DEF_LOOSE_BALLS_RECOVERED" => 3.5,
        "BOX_OUTS" => 12.0,
        "OFF_BOX_OUTS" => 3.5,
        "DEF_BOX_OUTS" => 8.5
      }
      all_team_headers.reject { |h| h == excluded_key }.map { |h| row_data[h] }
    end
    # rubocop:enable Metrics/MethodLength
  end
  # rubocop:enable Metrics/ClassLength
end
