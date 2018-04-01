require 'money'

module Transactional
  def all_transactions
    @all_transactions ||= []
  end

  def add_transaction(transaction)
    all_transactions << transaction
    all_transactions.sort_by!(&:date)
  end

  def transactions_to_date(date)
    all_transactions.take_while do |transaction|
      transaction.date <= date
    end
  end

  def balance(date)
    Money.new(transactions_to_date(date).sum(&:amount))
  end
end
