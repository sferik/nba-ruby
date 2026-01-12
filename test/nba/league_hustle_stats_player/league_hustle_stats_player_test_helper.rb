module NBA
  module LeagueHustleStatsPlayerTestHelper
    def stat_headers
      %w[PLAYER_ID PLAYER_NAME TEAM_ID TEAM_ABBREVIATION AGE G MIN
        CONTESTED_SHOTS CONTESTED_SHOTS_2PT CONTESTED_SHOTS_3PT
        DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS SCREEN_AST_PTS
        OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED LOOSE_BALLS_RECOVERED
        PCT_LOOSE_BALLS_RECOVERED_OFF PCT_LOOSE_BALLS_RECOVERED_DEF
        OFF_BOXOUTS DEF_BOXOUTS BOX_OUT_PLAYER_TEAM_REBS BOX_OUT_PLAYER_REBS BOX_OUTS
        PCT_BOX_OUTS_OFF PCT_BOX_OUTS_DEF PCT_BOX_OUTS_TEAM_REB PCT_BOX_OUTS_REB]
    end

    def stat_row
      [201_939, "Stephen Curry", Team::GSW, "GSW", 36, 72, 34.5,
        156, 98, 58,
        85, 5, 142, 284,
        25, 35, 60,
        0.417, 0.583,
        12, 45, 38, 22, 57,
        0.211, 0.789, 0.667, 0.386]
    end

    def build_response_without_key(key)
      headers = stat_headers.reject { |h| h.eql?(key) }
      row_data = stat_headers.zip(stat_row).to_h
      row_data.delete(key)
      row = headers.map { |h| row_data[h] }
      {resultSets: [{name: "HustleStatsPlayer", headers: headers, rowSet: [row]}]}
    end
  end
end
