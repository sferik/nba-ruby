module NBA
  class CLI < Thor
    module Formatters
      # Formatters for team-related output
      module TeamFormatters
        # Eastern Conference team abbreviations
        #
        # @api private
        # @return [Array<String>]
        EAST = %w[ATL BOS BKN CHA CHI CLE DET IND MIA MIL NYK ORL PHI TOR WAS].freeze

        # Division mappings by team abbreviation
        #
        # @api private
        # @return [Hash]
        DIVISIONS = {
          %w[BOS BKN NYK PHI TOR] => "Atlantic", %w[CHI CLE DET IND MIL] => "Central",
          %w[ATL CHA MIA ORL WAS] => "Southeast", %w[DEN MIN OKC POR UTA] => "Northwest",
          %w[GSW LAC LAL PHX SAC] => "Pacific", %w[DAL HOU MEM NOP SAS] => "Southwest"
        }.freeze

        # Returns the team nickname for display
        #
        # @api private
        # @return [String]
        def team_nickname(team)
          return "TBD" unless team

          team.nickname || team.full_name&.split&.last || "TBD"
        end

        # Returns the conference name for a team
        #
        # @api private
        # @return [String]
        def conference_name(detail)
          EAST.include?(detail.abbreviation.to_s) ? "Eastern Conference" : "Western Conference"
        end

        # Returns the division name for a team
        #
        # @api private
        # @return [String, nil]
        def division_name(detail)
          division_for_team(detail.abbreviation.to_s)
        end

        # Looks up the division for a team abbreviation
        #
        # @api private
        # @return [String, nil]
        def division_for_team(abbr)
          division = DIVISIONS.find { |teams, _| teams.include?(abbr) }&.last
          "#{division} Division" if division
        end

        # Returns whether the stat represents a championship year
        #
        # @api private
        # @return [Boolean]
        def championship_year?(stat)
          stat.nba_finals_appearance.eql?("LEAGUE CHAMPION")
        end
      end
    end
  end
end
