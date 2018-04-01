require 'money'
require 'byebug'

module Transactional
  def add_repeated_transfer(repeated_transfer)
    repeated_transfers << repeated_transfer
  end

  def add_transaction(transaction)
    transactions << transaction
  end

  def transactions_to_date(date)
    one_off_transactions = transactions.select { |transaction| transaction.date <= date }
    scheduled_transactions = repeated_transfers.flat_map { |t| t.transactions_until_date(date) }

    (one_off_transactions + scheduled_transactions).sort_by(&:date)
  end

  def balance(date)
    Money.new(transactions_to_date(date).sum(&:amount))
  end

  private

  def repeated_transfers
    @repeated_transfers ||= []
  end

  def transactions
    @transactions ||= []
  end
end
