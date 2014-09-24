class Countdown
  def initialize(limit)
    @limit = limit
    reset!
  end

  def add_minutes(minutes)
    @minutes_left -= minutes
    @minutes_left = 0 if @minutes_left < 0
  end

  def ready?
    @minutes_left == 0
  end

  def reset!
    @minutes_left = @limit
  end

  def to_i
    @minutes_left
  end
end
