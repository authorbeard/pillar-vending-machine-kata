require 'byebug'
require 'vending_machine'

describe VendingMachine do 
  
  vend=VendingMachine.new

  PRODUCTS=[['cola', 1.00], ['chips', 0.50], ['candy', 0.65]]

  it "can instatiate a vending machine" do
    expect(vend.instance_of?(VendingMachine)).to eq(true)
  end

  it "has products" do
    # byebug
    expect(vend.products.length).to eq(3)
    expect(vend.products.first[:price]).to eq(100)
  end

  it "displays products" do
    allow($stdout).to receive(:puts)
    
    expect(vend.display_products).to eq("1. cola: $1.00\n2. chips: $0.50,\n3. candy: $0.65")
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
  end

  describe "#select_product" do 

  end

end