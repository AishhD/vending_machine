class Cli

    def initialize(users_coins, tills_coins, products)
        @coins = Coins.new
        @users_coins = UsersMoney.new(users_coins)
        @tills_coins = TillsMoney.new(tills_coins)
        @products = Products.new(products)
        @display_options = DisplayOptions.new()
    end

    def run
        greet
        puts @products.list_products
        separate
        @users_coins.list_coins
        @display_options.initial_options
    end

    def greet
        puts "Welcome to the vending machine"
    end

    def separate
        puts "------------------------------------"
    end

end
