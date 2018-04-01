require_relative 'liability'
require_relative 'monthly_transfer'
require_relative 'transaction'
require_relative 'daily_compounding_interest'

class Mortgage < Liability
  # TODO: Support some sort of monthly compounding from the interest.

  attr_reader :date_initiated, :amount, :monthly_repayment, :annual_interest_rate

  def initialize(date_initiated:, amount:, monthly_repayment:, annual_interest_rate:)
    @date_initiated = date_initiated
    @amount = amount
    @monthly_repayment = monthly_repayment
    @annual_interest_rate = annual_interest_rate

    setup_mortgage
  end

  def value(date)
    balance_on_date = interest.value(
      transactions: transactions_to_date(date),
      day: date
    )

    return balance_on_date < 0 ? balance_on_date : Money.new(0)
  end


  private

  def interest
    @interest ||= DailyCompoundingInterest.new(rate: annual_interest_rate)
  end

  def setup_mortgage
    # Take out the mortgage.
    add_transaction(Transaction.new(
      amount: -amount,
      date: date_initiated
    ))

    # Schedule the repayments.
    add_repeated_transfer(MortgageRepayment.new(
      amount: monthly_repayment,
      schedule_from: date_initiated
    ))
  end

  class MortgageRepayment < MonthlyTransfer
  end
end
