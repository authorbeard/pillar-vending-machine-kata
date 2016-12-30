require 'byebug'

class VendingMachine
  attr_accessor :products

  COINS = {
    "nickel" => 5,
    "dime" => 10,
    "quarter" => 25
  }

  def initialize
    self.products = {'cola' => 1.00, 'chips' => 0.50, 'candy' => 0.65}
    display_products
  end

  def accept_coins(coin_name)
    if coin_name.downcase == "penny"
      return "I can't accept pennies, bub."
    elsif COINS[coin_name] == nil 
      return "I only take nickels, dimes or quarters"
    else
      return COINS[coin_name]
    end

  end
end