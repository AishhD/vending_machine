# Vending Machine

# Requirements

- Once an item is selected and the appropriate amount of money is inserted, the vending
  machine should return the correct product.
- It should also return change if too much money is provided, or ask for more money if
  insufficient funds have been inserted.
- The machine should take an initial load of products and change. The change will be of
  denominations 1p, 2p, 5p, 10p, 20p, 50p, £1, £2.
- There should be a way of reloading either products or change at a later point.
- The machine should keep track of the products and change that it contains.

## Getting Started

To start type

```
bundle install
```

To run the program type

```
ruby bin/run.rb
```

## Input

Input can be changed in the bin/run.rb file.

The should cointain the following variables: users_coins, products, vending_machine_coins

users_coins and vending_machine_coins should be an array of strings. Each string should contain one of the following: 1p, 2p, 5p, 10p, 20p, 50p, £1, £2.

For example

```
users_coins = ["1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2"]
```

products should contain nested hashes. The first has would have the product name as the key with the value of a hash. This hash will have a key of the coin type as a string and should be one of the following: 1p, 2p, 5p, 10p, 20p, 50p, £1, £2. The value of the hash will be the value of the coin in pennies, so £1 would have a value of 100

For example

```
products = {"Kettle crips" => {"£1" => 100}, "Walkers crips" => {"50p" => 50}, "Popchips" => {"65p" => 65}, "Sensations" => {"£1.50" => 150}, "Quavers" => {"80p" => 80}}
```

The run file should then have the following

```
cli = Cli.new(users_coins, products, vending_machine_coins)

cli.run
```

## Running the tests

To run the test type

```
rspec
```

## Built With

- Ruby - A dynamic, interpreted, reflective, object-oriented, general-purpose programming language.

## Gems

- [require_all](https://github.com/jarmo/require_all) - A simple way to load your code.
- [pry](https://github.com/pry/pry) - A runtime developer console and IRB alternative with powerful introspection capabilities.

## Author

**Aisha D'Souza**
