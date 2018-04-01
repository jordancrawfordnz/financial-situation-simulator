require_relative 'asset'
require_relative 'daily_compounding_interest'

class Investment < Asset
  attr_reader :typical_annual_growth

  def initialize(typical_annual_growth:)
    @typical_annual_growth = typical_annual_growth
  end

  def value(day)
    investment_growth.value(
      transactions: transactions_to_date(day),
      day: day
    )
  end

  private

  def investment_growth
    @investment_growth ||= DailyCompoundingInterest.new(rate: typical_annual_growth)
  end
end
