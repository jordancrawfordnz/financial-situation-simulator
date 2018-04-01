require_relative 'asset'

class Investment < Asset
  attr_reader :value, :typical_annual_growth

  def initialize(typical_annual_growth:)
    @typical_annual_growth = typical_annual_growth
  end

  def value(day)
    investment_growth = Money.new(0)

    transactions_to_date(day).map(&:date).push(day).uniq.each_cons(2) do |(period_start_date, period_end_date)|
      days_passed = (period_end_date - period_start_date).to_i

      balance_at_start_of_period = balance(period_start_date) + investment_growth
      investment_growth += (balance_at_start_of_period * (1 + daily_increase_rate) ** days_passed) - balance_at_start_of_period
    end

    balance(day) + investment_growth
  end

  private

  def daily_increase_rate
    @daily_increase_rate ||= BigDecimal.new(typical_annual_growth) / (100 * 365)
  end
end
