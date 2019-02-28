require_relative '../lib/cli'
require_relative '../lib/coin'
require_relative '../lib/vending_machine'
require_relative '../lib/product'

describe Cli do
    before :each do
        @set_users_coins = ["1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2"]
        @set_vending_machine_coins = ["1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2", "1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2", "1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2"]
        @set_products = {"Kettle crips" => {"£1" => 100}, "Walkers crips" => {"50p" => 50}, "Popchips" => {"65p" => 65}, "Sensations" => {"£1.50" => 150}, "Quavers" => {"80p" => 80}}
        @cli = Cli.new(@set_users_coins, @set_products, @set_vending_machine_coins)
      end


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

end