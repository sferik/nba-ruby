module NBA
  # Provides statistical helper methods for stat objects
  #
  # This module adds per-minute normalization methods to stat objects
  # that have a `min` attribute representing minutes played.
  #
  # @api public
  module StatHelpers
    # The standard minutes base for per-36 normalization
    PER_36_MINUTES = 36

    # The standard minutes base for per-40 normalization
    PER_40_MINUTES = 40

    # Returns the per-minute value of a statistic
    #
    # @api public
    # @example
    #   log.per_minute(:pts) #=> 0.88
    # @param stat [Symbol] the stat attribute name
    # @return [Float, nil] the per-minute value, or nil if minutes is zero/nil
    def per_minute(stat)
      return unless positive_minutes?

      stat_value = public_send(stat)
      return unless stat_value

      stat_value / minutes_value
    end

    # Returns the per-36-minutes normalized value of a statistic
    #
    # @api public
    # @example
    #   log.per36(:pts) #=> 31.76
    # @param stat [Symbol] the stat attribute name
    # @return [Float, nil] the per-36-minutes value, or nil if minutes is zero/nil
    def per36(stat)
      per_minutes(stat, PER_36_MINUTES)
    end

    # Returns the per-40-minutes normalized value of a statistic
    #
    # @api public
    # @example
    #   log.per40(:pts) #=> 35.29
    # @param stat [Symbol] the stat attribute name
    # @return [Float, nil] the per-40-minutes value, or nil if minutes is zero/nil
    def per40(stat)
      per_minutes(stat, PER_40_MINUTES)
    end

    private

    # Returns the normalized value for a given minute base
    #
    # @api private
    # @param stat [Symbol] the stat attribute name
    # @param base [Integer] the minute base for normalization
    # @return [Float, nil] the normalized value
    def per_minutes(stat, base)
      rate = per_minute(stat)
      return unless rate

      rate * base
    end

    # Returns the numeric minutes value
    #
    # Handles both Integer (GameLog) and Float (CareerStats) minute formats.
    #
    # @api private
    # @return [Float] the minutes value
    def minutes_value
      min.to_f
    end

    # Returns whether minutes is positive
    #
    # @api private
    # @return [Boolean] true if minutes is greater than zero
    def positive_minutes?
      minutes_value.positive?
    end
  end
end
