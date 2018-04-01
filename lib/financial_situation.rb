class FinancialSituation
  attr_reader :day, :assets, :transfers

  # A financial situation tracks the assets, liabilities, etc at a point in time.
  # It can be used to determine the financial situation as of a particular day.

  def initialize(day:, assets: [], transfers: [])
    @day = day
    @assets = assets
    @transfers = transfers
  end

  def total_assets
    assets.sum { |asset| asset.value(day) }
  end
end
