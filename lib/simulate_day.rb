require_relative 'financial_situation'

class SimulateDay
  attr_reader :for_day, :current_situation

  def initialize(for_day:, current_situation:)
    @for_day = for_day
    @current_situation = current_situation
  end

  def run
    # TODO: Make changes to the owned assets as required and schedule transactions between them.

    FinancialSituation.new(day: for_day, assets: current_situation.assets)
  end
end
