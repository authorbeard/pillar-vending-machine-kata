require 'byebug'

class VendingMachine
  attr_accessor :products, :current_amount, :current_selection

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
    @current_amount = 0

  end

  def accept_coins(coin_name)
    if coin_name.downcase == "penny"
      return "I can't accept pennies, bub."
    elsif COINS[coin_name] == nil 
      return "I only take nickels, dimes or quarters"
    else
      @current_amount += COINS[coin_name]
      return COINS[coin_name]
    end
  end

  def select_product
    puts "Please make a selection."    
    user_input = gets
    @current_selection = button_press(user_input)
    if @current_selection[:price] == @current_amount
      dispense_product
    end

  end

  def button_press(u_input)
    return @products[u_input.to_i-1]
  end

  def dispense_product
    @current_amount = 0
    @current_selection = nil
    puts "THANK YOU"
  end

  # def check_display
  #   if 

  # end

end