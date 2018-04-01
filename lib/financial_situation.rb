class FinancialSituation
  attr_reader :day, :assets

  # A financial situation tracks the assets, liabilities, etc at a point in time.
  # It can be used to determine the financial situation as of a particular day.

  def initialize(day:, assets: [])
    @day = day
    @assets = assets
  end

  def total_assets
    asset_values.values.sum
  end

  def value_of(asset)
    asset_values[asset]
  end

  private

  def asset_values
    @asset_values ||= assets.each_with_object({}) do |asset, asset_values|
      asset_values[asset] = asset.value(day)
    end
  end
end
