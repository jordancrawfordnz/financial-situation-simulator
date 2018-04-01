require_relative 'transaction'
require_relative 'regular_transfer'

class WeeklyTransfer < RegularTransfer
  TRANSFER_EFFECTIVE_WDAY = 7 # Do transfers on Sunday

  def transactions_until_date(date)
    transactions_until = [date, schedule_until].compact.min

    (schedule_from...transactions_until).each.map do |day|
      Transaction.new(
        amount: amount,
        date: day
      ) if day.cwday == TRANSFER_EFFECTIVE_WDAY
    end.compact
  end
end
