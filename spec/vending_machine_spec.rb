require 'byebug'
require 'vending_machine'

describe VendingMachine do 
  
  vend=VendingMachine.new

  it "can instatiate a vending machine" do
    expect(vend.instance_of?(VendingMachine)).to eq(true)
    expect(vend.current_amount).to eq(0)
    expect(vend.current_selection).to eq(nil)
    expect(vend.coin_return).to eq(0)
  end

  it "has products" do
    expect(vend.products.length).to eq(3)
    expect(vend.products.first[:price]).to eq(100)
  end

  describe "#accept_coins" do
  vend=VendingMachine.new

    it "identifies coins based on string passed to it" do
      expect(vend.accept_coins("penny")).to eq("I can't accept pennies, bub.")
    end

    it "rejects coins that aren't nickels, dimes or quarters" do 
      expect(vend.accept_coins("silver_dollar")).to eq("I only take nickels, dimes or quarters")
    end

    it "assigns integer value based on coin name" do
      expect(vend.accept_coins("nickel")).to eq(5)
      expect(vend.accept_coins("dime")).to eq(10)
      expect(vend.accept_coins("quarter")).to eq(25) 
    end

    it "keeps track of coins added" do
      expect(vend.current_amount).to eq(40)
    end
  end

  describe "#select_product" do 
    vend=VendingMachine.new

    it 'prompts user to make a selection' do
      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with("Please make a selection.")

      expect(vend).to receive(:gets).and_return(2)

      vend.select_product
    end

    it 'checks the stock of an item' do
      expect(vend).to receive(:gets).and_return(1)
      expect(vend).to receive(:sold_out?)

      vend.select_product
    end

    it 'dispenses product when the user has inserted enough money' do
      vend.current_amount = 50
      vend.current_selection = nil

      expect(vend).to receive(:gets).and_return(2) 

      vend.select_product

      expect(vend).to_not receive(:dispense_product)
      expect(vend.current_selection).to eq(nil)
    end

    it 'checks for change when appropriate' do
      vend.current_amount = 125
      vend.current_selection = vend.products[0]

      expect(vend).to receive(:gets).and_return(2) 
      expect(vend).to receive(:make_change)

      vend.select_product
    end

    it 'calculates correct change' do
      vend.current_amount = 125
      vend.current_selection = vend.products[0]
      expect(vend).to receive(:gets).and_return(1)      
      vend.select_product

      expect(vend.coin_return).to eq(25)
    end

    it 'checks display after a product has been dispensed' do
      vend.current_amount=50

      expect(vend).to receive(:gets).and_return(3) 
      expect(vend).to receive(:check_display)

      vend.select_product
    end

    it 'prompts for coins when a selection is made without money added' do
      vend.current_amount = 0 

      expect(vend).to receive(:gets).and_return(2) 
      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with("INSERT COINS")

      vend.select_product
    end

    it 'displays current amount when selection made without sufficient money added' do
      vend.current_amount = 40

      expect(vend).to receive(:gets).and_return(2)
      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with("CURRENT AMOUNT: 40")

      vend.select_product
    end

    describe '#dispense_product' do
      it 'reduces the stock of the item by 1' do
        vend.add_products
        vend.current_selection=vend.products[3]
        vend.current_amount=vend.current_selection[:price]
        stock=vend.current_selection[:stock]

        vend.dispense_product

        expect(vend.products[3][:stock]).to eq(stock-1)

      end
      
      it 'thanks the user and resets current_selection and current_amount' do

      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with("THANK YOU")

      vend.dispense_product

      expect(vend.current_amount).to eq(0)
      expect(vend.current_selection).to eq(nil)
      end

    end

    describe "#button_press" do
      it 'returns the correct item' do 
        item=vend.button_press(2)
        expect(item[:name]).to eq("chips")
      end
    end

    describe '#check_display' do
      vend.current_amount=0

      it 'prompts user to insert coins when none have been added' do
        allow($stdout).to receive(:puts)
        expect($stdout).to receive(:puts).with('INSERT COINS')

        vend.check_display
      end

      it 'displays current amount when coins have been added' do
        vend.current_amount = 25
        allow($stdout).to receive(:puts)
        expect($stdout).to receive(:puts).with("CURRENT AMOUNT: 25")

        vend.check_display
      end

      it 'displays current item price and correct prompt when a selection has been made' do
        vend.current_selection = {name: "candy", price: 65}
        allow($stdout).to receive(:puts)
        expect($stdout).to receive(:puts).with("PRICE: 65")

        vend.check_display

        allow($stdout).to receive(:puts)
        expect($stdout).to receive(:puts).with("CURRENT AMOUNT: 25")

        vend.check_display

        vend.current_amount = 0

        allow($stdout).to receive(:puts)
        expect($stdout).to receive(:puts).with("INSERT COINS")

        vend.check_display
      end

    end

  end

  describe "#make_change" do
    vm = VendingMachine.new(150, 1)

    it "calculates the correct amount of change and adds it to the coin_return" do
      vm.make_change
      expect(vm.coin_return).to eq(50)
    end
  end

  describe "#return_coins" do
    vm = VendingMachine.new(75)
    it "returns the user's inserted amount and resets the current_amount" do

      expect($stdout).to receive(:puts).with("INSERT COINS")

      vm.return_coins
      expect(vm.current_amount).to eq(0)

    end
  end

  describe "#sold_out?" do
    vm = VendingMachine.new(50, 1)
    vm.products[1][:stock] = 0

    it 'checks to see if the current_selection is still in stock' do
      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with('SOLD OUT')
      expect(vm).to receive(:check_display)

      vm.sold_out?(2)
      expect(vm.current_selection).to eq(nil)
    end
  end

end