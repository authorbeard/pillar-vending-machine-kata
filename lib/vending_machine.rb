require 'byebug'

class VendingMachine

  COINS = {
    "nickel" => 5,
    "dime" => 10,
    "quarter" => 25
  }

  def initialize
  end

  def accept_coins(coin_name)
    if coin_name.downcase == "penny"
      return "I can't accept pennies, bub."
    elsif COINS[coin_name] == nil 
      return "I only take nickels, dimes or quarters"
      
    end

  end
end