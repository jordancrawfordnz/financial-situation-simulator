class SimulateDay
  attr_reader :day, :initial_state, :variables

  def initialize(day:, initial_state:, variables:)
    @day = day
    @initial_state = initial_state
    @variables = variables
  end

  def run
    new_savings = initial_state.savings

    if end_of_month?
      new_savings *= (1 + monthly_savings_rate)
    end

    DayState.new(day: day, savings: new_savings)
  end

  private

  def end_of_month?
    day.month + 1 == (day + 1).month
  end

  def monthly_savings_rate
    BigDecimal.new(variables.annualised_interest_rate) / (100 * 12)
  end
end
