class FinancialSituation
  attr_reader :day, :assets

  # A financial situation tracks the assets, liabilities, etc at a point in time.
  # It can be used to determine the financial situation as of a particular day.

  def initialize(day:, assets: [])
    @day = day
    @assets = assets
  end

  def total_assets
    assets.sum { |asset| asset.value(day) }
  end
end
