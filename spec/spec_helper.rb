# require "bundler/setup"
# require "vending_machine"

RSpec.configure do |config|

  config.before :each do
    @set_users_coins = ["1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2"]
    @set_vending_machine_coins = ["1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2", "1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2", "1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2"]
    @set_products = {"Kettle crips" => {"£1" => 100}, "Walkers crips" => {"50p" => 50}, "Popchips" => {"65p" => 65}, "Sensations" => {"£1.50" => 150}, "Quavers" => {"80p" => 80}}
    @cli = Cli.new(@set_users_coins, @set_products, @set_vending_machine_coins)
  end

end