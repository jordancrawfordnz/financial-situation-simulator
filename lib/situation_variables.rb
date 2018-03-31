class SituationVariables
  attr_reader :annualised_interest_rate

  def initialize(annualised_interest_rate:)
    @annualised_interest_rate = annualised_interest_rate
  end
end
