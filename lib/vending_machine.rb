require 'byebug'

class VendingMachine

  COINS = {}

  def initialize
  end

  def accept_coins(coin_name)
    if coin_name.downcase == "penny"
      return "I can't accept pennies, bub."
    end

  end
end