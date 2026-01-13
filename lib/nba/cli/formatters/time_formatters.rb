module NBA
  class CLI < Thor
    module Formatters
      # Formatters for time-related output
      module TimeFormatters
        # Pattern to match Eastern time format (e.g., "7:30 pm ET")
        # @return [Regexp] the time pattern
        ET_TIME_PATTERN = /\A(\d{1,2}):(\d{2})\s*(am|pm)\s*ET\z/i

        # Converts Eastern time to local time zone
        #
        # @api private
        # @param status [String] the status string (may contain ET time)
        # @return [String] the status with time converted to local zone
        def convert_et_to_local(status)
          match = ET_TIME_PATTERN.match(status)
          return status unless match

          format_local_time(parse_et_time(match))
        end

        # Parses Eastern time components into a Time object
        #
        # @api private
        # @param match [MatchData] the regex match with hour, minute, am/pm
        # @return [Time] the time in Eastern timezone
        def parse_et_time(match)
          hour = Integer(match[1] || 0)
          minute = Integer(match[2] || 0)
          period = (match[3] || "am").downcase

          hour = convert_to_24h(hour, period)
          build_et_time(hour, minute)
        end

        # Converts 12-hour format to 24-hour format
        #
        # @api private
        # @param hour [Integer] the hour in 12-hour format
        # @param period [String] "am" or "pm"
        # @return [Integer] the hour in 24-hour format
        def convert_to_24h(hour, period)
          if period.eql?("am")
            hour.eql?(12) ? 0 : hour
          else
            hour.eql?(12) ? 12 : hour + 12
          end
        end

        # Builds a Time object in Eastern timezone
        #
        # @api private
        # @param hour [Integer] the hour in 24-hour format
        # @param minute [Integer] the minute
        # @return [Time] the time in Eastern timezone
        def build_et_time(hour, minute)
          today = Date.today
          Time.new(today.year, today.month, today.day, hour, minute, nil, "-05:00")
        end

        # Formats a time in the local timezone
        #
        # @api private
        # @param et_time [Time] the time in Eastern timezone
        # @return [String] formatted local time string
        def format_local_time(et_time)
          local_time = et_time.localtime
          zone_abbr = local_time_zone_abbr
          local_time.strftime("%-I:%M %p #{zone_abbr}")
        end

        # Returns the local timezone abbreviation
        #
        # @api private
        # @return [String] the timezone abbreviation (e.g., "PST", "EST")
        def local_time_zone_abbr
          Time.now.zone || "ET"
        end
      end
    end
  end
end
