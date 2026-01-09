require "equalizer"
require "shale"

module NBA
  # Represents a video status entry
  class VideoStatusEntry < Shale::Mapper
    include Equalizer.new(:game_id)

    # @!attribute [rw] game_id
    #   Returns the game ID
    #   @api public
    #   @example
    #     entry.game_id #=> "0022300001"
    #   @return [String] the game ID
    attribute :game_id, Shale::Type::String

    # @!attribute [rw] game_date
    #   Returns the game date
    #   @api public
    #   @example
    #     entry.game_date #=> "2023-10-24"
    #   @return [String] the game date
    attribute :game_date, Shale::Type::String

    # @!attribute [rw] visitor_team_id
    #   Returns the visiting team ID
    #   @api public
    #   @example
    #     entry.visitor_team_id #=> 1610612744
    #   @return [Integer] the visiting team ID
    attribute :visitor_team_id, Shale::Type::Integer

    # @!attribute [rw] visitor_team_city
    #   Returns the visiting team city
    #   @api public
    #   @example
    #     entry.visitor_team_city #=> "Golden State"
    #   @return [String] the visiting team city
    attribute :visitor_team_city, Shale::Type::String

    # @!attribute [rw] visitor_team_name
    #   Returns the visiting team name
    #   @api public
    #   @example
    #     entry.visitor_team_name #=> "Warriors"
    #   @return [String] the visiting team name
    attribute :visitor_team_name, Shale::Type::String

    # @!attribute [rw] visitor_team_abbreviation
    #   Returns the visiting team abbreviation
    #   @api public
    #   @example
    #     entry.visitor_team_abbreviation #=> "GSW"
    #   @return [String] the visiting team abbreviation
    attribute :visitor_team_abbreviation, Shale::Type::String

    # @!attribute [rw] home_team_id
    #   Returns the home team ID
    #   @api public
    #   @example
    #     entry.home_team_id #=> 1610612747
    #   @return [Integer] the home team ID
    attribute :home_team_id, Shale::Type::Integer

    # @!attribute [rw] home_team_city
    #   Returns the home team city
    #   @api public
    #   @example
    #     entry.home_team_city #=> "Los Angeles"
    #   @return [String] the home team city
    attribute :home_team_city, Shale::Type::String

    # @!attribute [rw] home_team_name
    #   Returns the home team name
    #   @api public
    #   @example
    #     entry.home_team_name #=> "Lakers"
    #   @return [String] the home team name
    attribute :home_team_name, Shale::Type::String

    # @!attribute [rw] home_team_abbreviation
    #   Returns the home team abbreviation
    #   @api public
    #   @example
    #     entry.home_team_abbreviation #=> "LAL"
    #   @return [String] the home team abbreviation
    attribute :home_team_abbreviation, Shale::Type::String

    # @!attribute [rw] game_status
    #   Returns the game status code
    #   @api public
    #   @example
    #     entry.game_status #=> 3
    #   @return [Integer] the game status code
    attribute :game_status, Shale::Type::Integer

    # @!attribute [rw] game_status_text
    #   Returns the game status text
    #   @api public
    #   @example
    #     entry.game_status_text #=> "Final"
    #   @return [String] the game status text
    attribute :game_status_text, Shale::Type::String

    # @!attribute [rw] is_available
    #   Returns the video availability flag
    #   @api public
    #   @example
    #     entry.is_available #=> 1
    #   @return [Integer] the video availability flag
    attribute :is_available, Shale::Type::Integer

    # @!attribute [rw] pt_xyz_available
    #   Returns the PT XYZ availability flag
    #   @api public
    #   @example
    #     entry.pt_xyz_available #=> 1
    #   @return [Integer] the PT XYZ availability flag
    attribute :pt_xyz_available, Shale::Type::Integer

    # Returns whether video is available
    #
    # @api public
    # @example
    #   entry.available? #=> true
    # @return [Boolean] true if video is available
    def available?
      is_available.eql?(1)
    end

    # Returns whether PT XYZ data is available
    #
    # @api public
    # @example
    #   entry.pt_xyz_available? #=> true
    # @return [Boolean] true if PT XYZ is available
    def pt_xyz_available?
      pt_xyz_available.eql?(1)
    end

    # Returns the home team object
    #
    # @api public
    # @example
    #   entry.home_team #=> #<NBA::Team>
    # @return [Team, nil] the home team object
    def home_team
      Teams.find(home_team_id)
    end

    # Returns the visiting team object
    #
    # @api public
    # @example
    #   entry.visitor_team #=> #<NBA::Team>
    # @return [Team, nil] the visiting team object
    def visitor_team
      Teams.find(visitor_team_id)
    end
  end
end
