require 'byebug'
require 'vending_machine'

describe VendingMachine do 
  it "can instatiate a vending machine" do
    vend=VendingMachine.new
    expect(vend.instance_of?(VendingMachine)).to eq(true)
  end
end