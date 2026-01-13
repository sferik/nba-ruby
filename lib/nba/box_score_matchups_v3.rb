require "json"
require_relative "client"
require_relative "collection"
require_relative "box_score_matchup_stat"
require_relative "utils"

module NBA
  # Provides methods to retrieve player matchup statistics using V3 API
  module BoxScoreMatchupsV3
    # @return [String] JSON key for matchup box score data
    BOX_SCORE_KEY = "boxScoreMatchups".freeze
    # @return [String] JSON key for player stats result set
    PLAYER_STATS = "PlayerStats".freeze

    # Retrieves player matchup stats for a game
    #
    # @api public
    # @example
    #   stats = NBA::BoxScoreMatchupsV3.find(game: "0022400001")
    #   stats.each { |stat| puts "#{stat.first_name_off} vs #{stat.first_name_def}" }
    # @param game [String, Integer, Game] the game ID or Game object
    # @param client [Client] the API client to use
    # @return [Collection] a collection of player matchup stats
    def self.find(game:, client: CLIENT)
      game_id = Utils.extract_id(game)
      response = client.get(build_path(game_id))
      parse_response(response, game_id)
    end

    # Builds the API request path
    # @api private
    # @return [String] the request path
    def self.build_path(game_id)
      "boxscorematchupsv3?GameID=#{game_id}"
    end
    private_class_method :build_path

    # Parses the API response into matchup stat objects
    # @api private
    # @return [Collection] collection of matchup stats
    def self.parse_response(response, game_id)
      return Collection.new unless response

      data = JSON.parse(response)
      matchups = extract_matchups(data)
      return Collection.new unless matchups

      Collection.new(matchups.map { |m| build_matchup_stat(m, game_id) })
    end
    private_class_method :parse_response

    # Extracts matchups from box score data
    # @api private
    # @param data [Hash] parsed JSON response
    # @return [Array, nil] array of matchup data or nil if not found
    def self.extract_matchups(data)
      box_score = data[BOX_SCORE_KEY]
      return unless box_score

      home = box_score.dig("homeTeam", "players") || []
      away = box_score.dig("awayTeam", "players") || []
      home + away
    end
    private_class_method :extract_matchups

    # Builds a matchup stat object from raw data
    # @api private
    # @return [BoxScoreMatchupStat] the matchup stat object
    def self.build_matchup_stat(matchup, game_id)
      BoxScoreMatchupStat.new(game_id: game_id, **team_identity(matchup), **player_identities(matchup),
        **matchup_stats(matchup))
    end
    private_class_method :build_matchup_stat

    # Extracts team identity attributes from matchup data
    # @api private
    # @return [Hash] team identity attributes
    def self.team_identity(matchup)
      {team_id: matchup["teamId"], team_city: matchup["teamCity"],
       team_name: matchup["teamName"], team_tricode: matchup["teamTricode"],
       team_slug: matchup["teamSlug"]}
    end
    private_class_method :team_identity

    # Extracts both offensive and defensive player identity attributes
    # @api private
    # @return [Hash] player identity attributes
    def self.player_identities(matchup)
      offensive_player_identity(matchup).merge(defensive_player_identity(matchup))
    end
    private_class_method :player_identities

    # Extracts offensive player identity attributes from matchup data
    # @api private
    # @return [Hash] offensive player identity attributes
    def self.offensive_player_identity(matchup)
      {person_id_off: matchup["personIdOff"], first_name_off: matchup["firstNameOff"],
       family_name_off: matchup["familyNameOff"], name_i_off: matchup["nameIOff"],
       player_slug_off: matchup["playerSlugOff"], jersey_num_off: matchup["jerseyNumOff"]}
    end
    private_class_method :offensive_player_identity

    # Extracts defensive player identity attributes from matchup data
    # @api private
    # @return [Hash] defensive player identity attributes
    def self.defensive_player_identity(matchup)
      {person_id_def: matchup["personIdDef"], first_name_def: matchup["firstNameDef"],
       family_name_def: matchup["familyNameDef"], name_i_def: matchup["nameIDef"],
       player_slug_def: matchup["playerSlugDef"], position_def: matchup["positionDef"],
       comment_def: matchup["commentDef"], jersey_num_def: matchup["jerseyNumDef"]}
    end
    private_class_method :defensive_player_identity

    # Extracts all matchup statistics
    # @api private
    # @return [Hash] combined matchup statistics
    def self.matchup_stats(matchup)
      matchup_time_stats(matchup).merge(matchup_counting_stats(matchup), matchup_shooting_stats(matchup))
    end
    private_class_method :matchup_stats

    # Extracts matchup time statistics from matchup data
    # @api private
    # @return [Hash] matchup time statistics
    def self.matchup_time_stats(matchup)
      {matchup_minutes: matchup["matchupMinutes"], matchup_minutes_sort: matchup["matchupMinutesSort"],
       partial_possessions: matchup["partialPossessions"],
       percentage_defender_total_time: matchup["percentageDefenderTotalTime"],
       percentage_offensive_total_time: matchup["percentageOffensiveTotalTime"],
       percentage_total_time_both_on: matchup["percentageTotalTimeBothOn"], switches_on: matchup["switchesOn"]}
    end
    private_class_method :matchup_time_stats

    # Extracts matchup counting statistics from matchup data
    # @api private
    # @return [Hash] matchup counting statistics
    def self.matchup_counting_stats(matchup)
      {player_points: matchup["playerPoints"], team_points: matchup["teamPoints"],
       matchup_assists: matchup["matchupAssists"], matchup_potential_assists: matchup["matchupPotentialAssists"],
       matchup_turnovers: matchup["matchupTurnovers"], matchup_blocks: matchup["matchupBlocks"]}
    end
    private_class_method :matchup_counting_stats

    # Extracts all matchup shooting statistics from matchup data
    # @api private
    # @return [Hash] matchup shooting statistics
    def self.matchup_shooting_stats(matchup)
      fg_stats(matchup).merge(three_pt_stats(matchup), help_and_ft_stats(matchup))
    end
    private_class_method :matchup_shooting_stats

    # Extracts field goal statistics from matchup data
    # @api private
    # @return [Hash] field goal statistics
    def self.fg_stats(data)
      {matchup_field_goals_made: data["matchupFieldGoalsMade"],
       matchup_field_goals_attempted: data["matchupFieldGoalsAttempted"],
       matchup_field_goals_percentage: data["matchupFieldGoalsPercentage"]}
    end
    private_class_method :fg_stats

    # Extracts three-pointer statistics from matchup data
    # @api private
    # @return [Hash] three-pointer statistics
    def self.three_pt_stats(data)
      {matchup_three_pointers_made: data["matchupThreePointersMade"],
       matchup_three_pointers_attempted: data["matchupThreePointersAttempted"],
       matchup_three_pointers_percentage: data["matchupThreePointersPercentage"]}
    end
    private_class_method :three_pt_stats

    # Extracts help defense and free throw statistics from matchup data
    # @api private
    # @return [Hash] help defense and free throw statistics
    def self.help_and_ft_stats(data)
      {help_blocks: data["helpBlocks"], help_field_goals_made: data["helpFieldGoalsMade"],
       help_field_goals_attempted: data["helpFieldGoalsAttempted"],
       help_field_goals_percentage: data["helpFieldGoalsPercentage"],
       matchup_free_throws_made: data["matchupFreeThrowsMade"],
       matchup_free_throws_attempted: data["matchupFreeThrowsAttempted"], shooting_fouls: data["shootingFouls"]}
    end
    private_class_method :help_and_ft_stats
  end
end
