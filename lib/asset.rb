require_relative 'transactional'

class Asset
  include Transactional

  def value(date)
    balance(date)
  end
end
