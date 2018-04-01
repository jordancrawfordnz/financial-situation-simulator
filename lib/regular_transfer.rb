class RegularTransfer
  attr_reader :amount, :schedule_from, :schedule_until

  def initialize(amount:, schedule_from:, schedule_until: nil)
    @amount = amount
    @schedule_from = schedule_from
    @schedule_until = schedule_until
  end
end
