require 'byebug'
require 'vending_machine'

describe VendingMachine do 
  
  vend=VendingMachine.new

  it "can instatiate a vending machine" do
    expect(vend.instance_of?(VendingMachine)).to eq(true)
    expect(vend.current_amount).to eq(0)
    expect(vend.current_selection).to eq(nil)
  end

  it "has products" do
    expect(vend.products.length).to eq(3)
    expect(vend.products.first[:price]).to eq(100)
  end

  describe "#accept_coins" do
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
    vend.current_amount = 0

    it 'prompts user to make a selection' do
      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with("Please make a selection.")

      expect(vend).to receive(:gets).and_return(2)

      vend.select_product
    end

    it 'selects a product based on button pushed' do
      expect(vend.current_selection[:name]).to eq ("chips")
    end

    it 'dispenses product and displays THANK YOU when the user has inserted enough money' do
      vend.current_amount = 50
      vend.current_selection = nil

      expect(vend).to receive(:gets).and_return(2)
      allow($stdout).to receive(:puts) 
 
      expect(vend).to receive(:dispense_product)

      vend.select_product

    end

    it 'sets current_amount to 0 and prompts user to insert coin after purchase' do
      expect(vend.current_amount).to eq(0)
      allow($stdout).to receive(:puts)
      expect($stdout).to receive(:puts).with('INSERT COIN')
    end

    describe '#check_display' do
      it 'prompts the user to insert coins if none have been added' do
        allow($stdout).to receive(:puts)
        expect($stdout).to recive(:puts).with('INSERT COIN')
      end
    end

  end

end