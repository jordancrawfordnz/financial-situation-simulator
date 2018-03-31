class Week
  attr_reader :start_date, :end_date

  def initialize(base_date)
    @start_date = mondayise(base_date)
    @end_date = start_date + 6
  end

  def previous
    self.class.new(start_date - 1)
  end

  def next
    self.class.new(end_date + 1)
  end

  private

  def mondayise(date)
    days_to_adjust = (date.wday + 6) % 7

    date - days_to_adjust
  end
end
