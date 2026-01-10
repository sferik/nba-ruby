module NBA
  module BoxScoreSummaryV2TestHelpers
    private

    def game_headers
      %w[GAME_DATE_EST GAME_STATUS_ID GAME_STATUS_TEXT HOME_TEAM_ID VISITOR_TEAM_ID SEASON LIVE_PERIOD LIVE_PC_TIME ATTENDANCE GAME_TIME]
    end

    def game_row
      ["2024-10-22", 3, "Final", Team::GSW, 1_610_612_747, "2024-25", 4, "0:00", 18_064, "2:18"]
    end

    def visitor_line_row
      [1_610_612_747, 25, 28, 30, 26, 0, 109]
    end

    def home_line_row
      [Team::GSW, 28, 30, 32, 25, 0, 115]
    end

    def line_headers
      %w[TEAM_ID PTS_QTR1 PTS_QTR2 PTS_QTR3 PTS_QTR4 PTS_OT1 PTS]
    end
  end
end
