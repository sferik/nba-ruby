module NBA
  module LeagueHustleStatsTeamTestHelper
    def stat_headers
      %w[TEAM_ID TEAM_NAME MIN
        CONTESTED_SHOTS CONTESTED_SHOTS_2PT CONTESTED_SHOTS_3PT
        DEFLECTIONS CHARGES_DRAWN SCREEN_ASSISTS SCREEN_AST_PTS
        OFF_LOOSE_BALLS_RECOVERED DEF_LOOSE_BALLS_RECOVERED LOOSE_BALLS_RECOVERED
        PCT_LOOSE_BALLS_RECOVERED_OFF PCT_LOOSE_BALLS_RECOVERED_DEF
        OFF_BOXOUTS DEF_BOXOUTS BOX_OUTS
        PCT_BOX_OUTS_OFF PCT_BOX_OUTS_DEF]
    end

    def stat_row
      [Team::GSW, "Golden State Warriors", 19_680.5,
        2856, 1842, 1014,
        1024, 42, 1856, 3712,
        312, 428, 740,
        0.422, 0.578,
        245, 1256, 1501,
        0.163, 0.837]
    end

    def build_response_without_key(key)
      headers = stat_headers.reject { |h| h.eql?(key) }
      row_data = stat_headers.zip(stat_row).to_h
      row_data.delete(key)
      row = headers.map { |h| row_data[h] }
      {resultSets: [{name: "HustleStatsTeam", headers: headers, rowSet: [row]}]}
    end
  end
end
