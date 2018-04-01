require_relative 'liability'
require_relative 'monthly_transfer'
require_relative 'transaction'

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

  private

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
    # TODO: Stop mortgage payments once paid off.
  end
end
