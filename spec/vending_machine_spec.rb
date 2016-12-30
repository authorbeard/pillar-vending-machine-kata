require 'byebug'
require 'vending_machine'

describe VendingMachine do 
  it "can instatiate a vending machine" do
    vend=VendingMachine.new
    vend.should_be_instance_of(VendingMachine)
  end
end