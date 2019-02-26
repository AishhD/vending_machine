require_relative '../config/environment'
require "pry"

users_coins = ["1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2"]
tills_coins = ["1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2", "1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2", "1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2"]
products = {"Kettle crips" => "£1", "Walkers crips" => "50p", "Popchips" => "65p", "Sensations" => "£1.50", "Quavers" => "80p"}

cli = Cli.new(users_coins, tills_coins, products)

cli.run