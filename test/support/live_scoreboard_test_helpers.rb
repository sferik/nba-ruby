module LiveScoreboardTestHelpers
  def stub_response_without(key)
    data = complete_game_data
    data.delete(key)
    stub_scoreboard_response([data])
  end

  def stub_response_with_missing_home_team_key(key)
    home_team = complete_home_team_data
    home_team.delete(key)
    data = game_data_with_custom_home_team(home_team)
    stub_scoreboard_response([data])
  end

  def stub_response_with_missing_away_team_key(key)
    away_team = complete_away_team_data
    away_team.delete(key)
    data = game_data_with_custom_away_team(away_team)
    stub_scoreboard_response([data])
  end

  private

  def complete_home_team_data
    {
      "teamId" => 1_610_612_744, "teamName" => "Warriors", "teamCity" => "Golden State",
      "teamTricode" => "GSW", "score" => 112
    }
  end

  def complete_away_team_data
    {
      "teamId" => 1_610_612_747, "teamName" => "Lakers", "teamCity" => "Los Angeles",
      "teamTricode" => "LAL", "score" => 108
    }
  end

  def base_game_info
    {
      "gameId" => "0022400001", "gameCode" => "20241022/LALGSW", "gameStatus" => 3,
      "gameStatusText" => "Final", "period" => 4, "gameClock" => "PT00M00.00S",
      "gameTimeUTC" => "2024-10-22T23:30:00Z", "gameEt" => "2024-10-22T19:30:00"
    }
  end

  def complete_game_data
    base_game_info.merge("homeTeam" => complete_home_team_data, "awayTeam" => complete_away_team_data)
  end

  def game_data_with_custom_home_team(home_team)
    base_game_info.merge("homeTeam" => home_team, "awayTeam" => complete_away_team_data)
  end

  def game_data_with_custom_away_team(away_team)
    base_game_info.merge("homeTeam" => complete_home_team_data, "awayTeam" => away_team)
  end

  def stub_scoreboard_response(games)
    response = {"scoreboard" => {"games" => games}}
    stub_request(:get, /cdn.nba.com/).to_return(body: response.to_json)
  end
end
