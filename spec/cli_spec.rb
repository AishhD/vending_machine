require_relative '../lib/cli'
require_relative '../lib/coin'
require_relative '../lib/vending_machine'
require_relative '../lib/product'

describe Cli do

    it 'initializes with @total at 0' do
        expect(@cli.total).to eq 0
    end

    it 'initializes with initial_arguments as the initialize arguements' do
        expect(@cli.initial_arguments).to eq [@set_users_coins, @set_products, @set_vending_machine_coins]
    end

    it 'initializes users_coins with each coin type' do
        expect(@cli.users_coins.map { |coin| coin.type}).to eq ["£2", "£1", "50p", "20p", "10p", "5p", "2p", "1p"]
    end

    it 'initializes users_coins with each coin value' do
        expect(@cli.users_coins.map { |coin| coin.value}).to eq [200, 100, 50, 20, 10, 5, 2, 1]
    end

    it 'initializes the vending machine with the correct products, price and value' do
        expect(@cli.vending_machine.products.map { |product| {product.name => {product.price[0] => product.value[0]}}}).to eq [{"Kettle crips"=>{"£1"=>100}},{"Walkers crips"=>{"50p"=>50}},{"Popchips"=>{"65p"=>65}},{"Sensations"=>{"£1.50"=>150}},{"Quavers"=>{"80p"=>80}}]
    end

    it 'outputs a line separator' do
        expect{@cli.separate}.to output("------------------------------------\n").to_stdout
    end

    it 'outputs a greeting' do
        expect{@cli.greet}.to output("Welcome to the vending machine\n").to_stdout
    end

    # it 'outputs a goodbye' do
    #     expect{@cli.exit}.to output("Goodbyen\n").to_stdout
    # end


    it 'list to out all the coins followed by a separator' do
        expect{@cli.list_coins}.to output("You have:\n£2 £1 50p 20p 10p 5p 2p 1p\n------------------------------------\n").to_stdout
    end

    it 'lists out all the menu options' do
        expect{@cli.main_menu_options}.to output("What would you like to do?\n(1) Choose a snack\n(2) Reset your balance\n(3) Reset vending machine\n(X) Exit\n").to_stdout
    end

    it 'set_total adds up the input value' do
        @cli.input_value = [1, 2, 3]
        expect(@cli.set_total).to eq 6
    end

end
