module LiveBoxScoreTestHelpers
  def all_stats
    counting_stats.merge(shooting_stats).merge("minutes" => "PT36M15.00S")
  end

  def counting_stats
    base_counting_stats.merge(game_stats)
  end

  def base_counting_stats
    {
      "points" => 32,
      "reboundsTotal" => 5,
      "reboundsOffensive" => 1,
      "reboundsDefensive" => 4,
      "assists" => 8,
      "steals" => 2,
      "blocks" => 0
    }
  end

  def game_stats
    {"turnovers" => 3, "foulsPersonal" => 2, "plusMinusPoints" => 12.0}
  end

  def shooting_stats
    field_goal_stats.merge(three_point_stats).merge(free_throw_stats)
  end

  def field_goal_stats
    {"fieldGoalsMade" => 11, "fieldGoalsAttempted" => 22, "fieldGoalsPercentage" => 0.5}
  end

  def three_point_stats
    {"threePointersMade" => 6, "threePointersAttempted" => 12, "threePointersPercentage" => 0.5}
  end

  def free_throw_stats
    {"freeThrowsMade" => 4, "freeThrowsAttempted" => 4, "freeThrowsPercentage" => 1.0}
  end

  def build_response_with_stats(stats)
    {
      game: {
        homeTeam: base_team_data.merge(
          players: [base_player_data.merge(statistics: stats)]
        ),
        awayTeam: nil
      }
    }
  end

  def build_response_with_player(player_data)
    {
      game: {
        homeTeam: base_team_data.merge(players: [player_data]),
        awayTeam: nil
      }
    }
  end

  def base_team_data
    {teamId: 1_610_612_744, teamTricode: "GSW"}
  end

  def base_player_data
    {
      personId: 201_939,
      name: "Stephen Curry",
      firstName: "Stephen",
      familyName: "Curry",
      jerseyNum: "30",
      position: "G",
      starter: "1"
    }
  end
end
