require 'byebug'

class VendingMachine
  attr_accessor :products, :current_amount, :current_selection, :coin_return

  COINS = {
    "nickel" => 5,
    "dime" => 10,
    "quarter" => 25
  }

  PRODUCTS = [
    {
      name: 'cola',
      price: 100,
      stock: 5
    },

    {
      name: 'chips', 
      price: 50,
      stock: 5
    },

    {
      name: 'candy',
      price: 65,
      stock: 5
    }
  ]

  def initialize(current_amount=0, current_selection=nil)   
    add_products
    @current_amount = current_amount
    @current_selection = @products[current_selection] if current_selection
    @coin_return=0
  end

  def add_products
    @products ||= []
    PRODUCTS.each{|p| @products << p}
  end

  def accept_coins(coin_name)
    if coin_name.downcase == "penny"
      return "I can't accept pennies, bub."
    elsif COINS[coin_name] == nil 
      return "I only take nickels, dimes or quarters"
    else
      @current_amount += COINS[coin_name]
      check_display
    end
  end

  def select_product
    puts "Please make a selection."    
    user_input = gets

    if sold_out?(user_input) 
      check_display
      return false
    end

    @current_selection = button_press(user_input)
    if @current_amount >= @current_selection[:price] 
      if @current_amount > @current_selection[:price]
        make_change
      end
      dispense_product
      check_display
    else
      check_display
    end

  end

  def button_press(u_input)
    return @products[u_input.to_i-1]
  end

  def dispense_product
    @products.find{|i| i == @current_selection}[:stock] -= 1
    @current_amount = 0
    @current_selection = nil
    puts "THANK YOU"
  end

  def check_display
    disp = ""
    if @current_selection
  byebug
      price = dollarize_amt(@current_selection[:price])
      puts "PRICE: #{price}"
    end

    if @current_amount==0
      puts 'INSERT COINS'
    else
      if exact_change
        puts "EXACT CHANGE ONLY"
      else
        amt = dollarize_amt(@current_selection[:price])
        puts "CURRENT AMOUNT: $#{amt}"
      end
    end
    return false
  end

  def make_change
    @coin_return = @current_amount - @current_selection[:price]
  end

  def return_coins
    @current_amount -= @current_amount
    check_display
  end

  def sold_out?(item)
    index = item - 1

    if @products[index][:stock] < 1
      @current_selection = nil
      puts "SOLD OUT"
      check_display
    end
  end

  def exact_change
    max = @products.collect{|i| i[:price]}.max
    if @current_amount > max
      if (@current_amount - max) % 5 != 0
        return "WHUT"
      else
        return true
      end
    else
      return false
    end
  end

  def dollarize_amt(integer)
    amt_string = (integer.to_f/100).to_s
    amt_string << "0" if amt_string.length == 3
    return amt_string
  end

end