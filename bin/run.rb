require_relative '../config/environment'
require "pry"

users_coins = ["1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2"]
tills_coins = ["1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2", "1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2", "1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2"]
products = {"Kettle crips" => {"£1" => 100}, "Walkers crips" => {"50p" => 50}, "Popchips" => {"65p" => 65}, "Sensations" => {"£1.50" => 150}, "Quavers" => {"80p" => 80}}

cli = Cli.new(users_coins, tills_coins, products)

cli.run