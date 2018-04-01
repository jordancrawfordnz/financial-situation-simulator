class DailyCompoundingInterest
  attr_reader :rate

  def initialize(rate:)
    @rate = rate
  end

  def value(day:, transactions:)
    compounding_periods(day: day, transactions: transactions).reduce(Money.new(0)) do |balance, compounding_period|
      days_passed = (compounding_period.end - compounding_period.start).to_i

      # Apply the transaction and calculate interest
      (balance + compounding_period.amount) * (1 + daily_increase_rate) ** days_passed
    end
  end

  private

  def daily_increase_rate
    @daily_increase_rate ||= BigDecimal.new(rate) / (100 * 365)
  end

  CompoundingPeriod = Struct.new(:start, :end, :amount)

  def compounding_periods(day:, transactions:)
    return [] if transactions.none?

    sorted_transactions = transactions.sort_by(&:date)
    compounding_periods = sorted_transactions.each_cons(2).map do |(first, second)|
      CompoundingPeriod.new(first.date, second.date, first.amount)
    end

    # Add a period on the end to count the gap between the last transaction and the end of the requested range.
    compounding_periods.push(CompoundingPeriod.new(sorted_transactions.last.date, day, sorted_transactions.last.amount))
  end
end
