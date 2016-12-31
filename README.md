This kata was completed in Ruby. At present it passes all the specs, but there's not much by way of interactivity set up. Or, at any rate, it's pretty partial (no CLI menu, no views, etc.)

## Setup

1. First things first, this was written in Ruby 2.3.0 with Rspec 3.5.0. The gemfile here specifies versions up to those points. 
2. It's easiest to use Bundler, so if you haven't installed that yet, do this: 

```
gem install bundler
```

3. Then you enter 

```
bundle install
```

4. At that point, all you really have to do is type in 'rspec' and it'll pretty much do the rest from there. 

## Notes
As you might notice if you've checked out the gemfile or either of the two Ruby documents here, you'll see that I've included byebug for debugging. So if you're curious about what's actually going on anywhere, you just type "byebug" and it'll jump in at that point and you can step through if you want. 

This implements, as strictly as possible, just the instructions contained [here](https://github.com/guyroyse/vending-machine-kata). At points, I've read between the lines and added some additional tests (a lot of the things, like checking the display, making change and dispensing products, simply make no sense unless they're embedded in other methods). I didn't do this throughout, since it led me astray here and there and I'm prone to belt-and-suspenders approaches that defeat the purpose of TDD--or at least one of them. 

You can instatiate a vending machine with a straightforward

```ruby
v = VendingMachine.new
```

You can also pass in some parameters: the current amount (in cents) currently inserted into the machine and the number of the current selection (not zero-indexed). Both are optional. But if you want to specify a current selection, you have to specify the amount. 

So if you want to start this with the second item ("chips") selected, this won't give you what you want: 

```ruby
v = VendingMachine.new(2)
```

Instead, it'll set the current_amount attribute to 2. Which is crazy talk, because this machine doesn't acept pennies. 

You'd have to do this: 

```ruby
v = VendingMachine.new(0, 2)
```

The vending machine populates its list of items based on a constant, PRODUCTS, listed at the top of lib/vending_machine.rb.

So if you want to add something, you add it there. You'll need a name and price. You don't necessarily need stock, but I've set it up to initialize with 5 items apiece. 

That's about it for now. Thanks for reading. 
