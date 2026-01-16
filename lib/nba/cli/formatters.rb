require_relative "formatters/time_formatters"
require_relative "formatters/team_formatters"
require_relative "formatters/game_formatters"
require_relative "formatters/standings_formatters"
require_relative "formatters/leaders_formatters"
require_relative "formatters/player_formatters"

module NBA
  class CLI < Thor
    # Helper methods for formatting CLI output
    module Formatters
      include TimeFormatters
      include TeamFormatters
      include GameFormatters
      include StandingsFormatters
      include LeadersFormatters
      include PlayerFormatters

      # Standard label width for formatted output
      #
      # @api private
      # @return [Integer]
      LABEL_WIDTH = 16

      # Returns the maximum string length from the given values
      #
      # @api private
      # @return [Integer]
      def max_length(values) = values.map { |v| v.to_s.length }.max

      # Centers a value within the given width
      #
      # @api private
      # @return [String]
      def center(value, width) = value.to_s.center(width)

      # Right-justifies a value within the given width
      #
      # @api private
      # @return [String]
      def rjust(value, width) = value.to_s.rjust(width)

      # ANSI escape code for green text
      #
      # @api private
      # @return [String]
      GREEN = "\e[32m".freeze

      # ANSI escape code to reset text formatting
      #
      # @api private
      # @return [String]
      RESET = "\e[0m".freeze

      # Wraps text in green color
      #
      # @api private
      # @return [String]
      def green(text) = "#{GREEN}#{text}#{RESET}"

      # Formats a label and value as a single line
      #
      # @api private
      # @return [String]
      def format_label(label, value) = "#{label}: #{value}"

      # Formats a label with multiple items across lines
      #
      # @api private
      # @return [String]
      def format_multiline_label(label, items)
        indent = " " * (label.length + 2)
        lines = items.each_slice(2).map { |pair| pair.join(", ") }
        first_line = "#{label}: #{lines.first}"
        continuation = lines.drop(1).map { |line| "#{indent}#{line}" }
        ([first_line] + continuation).join("\n")
      end
    end
  end
end
