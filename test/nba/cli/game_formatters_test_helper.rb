module NBA
  module GameFormattersTestHelper
    include CLI::Formatters::GameFormatters
    include CLI::Formatters::TeamFormatters
    include CLI::Formatters::TimeFormatters
    include CLI::Formatters

    private

    def mock_game(status, home_nickname, away_nickname, home_score, away_score)
      home = Team.new(nickname: home_nickname)
      away = Team.new(nickname: away_nickname)
      Game.new(
        status: status,
        home_team: home,
        away_team: away,
        home_score: home_score,
        away_score: away_score
      )
    end
  end
end
