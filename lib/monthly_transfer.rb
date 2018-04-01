require_relative 'transaction'

class MonthlyTransfer
  attr_reader :amount, :asset, :schedule_from, :schedule_until

  def initialize(amount:, asset:, schedule_from:, schedule_until: nil)
    @amount = amount
    @asset = asset
    @schedule_from = schedule_from
    @schedule_until = schedule_until
  end

  def transactions_until_date(date)
    transactions_until = [date, schedule_until].compact.min

    (months(schedule_from)...months(transactions_until)).each.map do |current_month|
      Transaction.new(amount: amount, date: end_of_month(current_month))
    end
  end

  private

  def months(date)
    date.year * 12 + date.month
  end

  def end_of_month(month_identifier)
    year, month = month_identifier.divmod(12)
    Date.new(year, month + 1, -1)
  end
end
