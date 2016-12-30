require 'byebug'

class VendingMachine
  attr_accessor :products

  COINS = {
    "nickel" => 5,
    "dime" => 10,
    "quarter" => 25
  }

  PRODUCTS = [
    {
      name: 'cola',
      price: 100
    },

    {
      name: 'chips', 
      price: 50
    },

    {
      name: 'candy',
      price: 65
    }
  ]

  def initialize
    @products = PRODUCTS   
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

  def select_product
    puts "Please make a selection."
    
    user_input = gets

    prod=button_press(user_input)

  end

  def button_press(u_input)
    return @products[u_input.to_i-1]
  end

end