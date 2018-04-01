require_relative 'transactional'

class Liability
  include Transactional

  def value(date)
    balance(date)
  end
end
