class DayState
  attr_reader :day, :savings

  def initialize(day:, savings:)
    @day = day
    @savings = savings
  end
end
