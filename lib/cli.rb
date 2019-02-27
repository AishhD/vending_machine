class Cli

    def initialize(users_coins, tills_coins, products)
        @coins = Coins.new
        @users_coins = UsersMoney.new(users_coins)
        @tills_coins = TillsMoney.new(tills_coins)
        @products = Products.new(products)
        @current_products = @products
        @current_tills_coins = @tills_coins
        @current_users_coins = @users_coins
    end

    def run
        greet
        puts @products.list_products
        until @products.products === 0
            run_vending_machine
        end
        puts "No more products, goodbye"
    end

    def run_vending_machine
        separate
        @users_coins.list_coins
        display_initial_options
        handle_initial_options
    end

    def greet
        puts "Welcome to the vending machine"
    end

    def separate
        puts "------------------------------------"
    end
  
    def exit 
        abort("Goodbye")
    end
  
    def display_initial_options
        puts "What would you like to do?"
        options = { '1' => 'Choose a snack', '2' => 'Reset snack', '3' => 'Reset your balance', '4' => 'Reset tills balance', 'X' => 'Exit' }
        options.each do |indicator, option|
        puts "(#{indicator}) #{option}"
        end
    end
  
    def handle_initial_options(input=nil)
        if (!input)
          input = gets.chomp.capitalize
        end
        case input 
          when "1"
            puts @products.list_products
            user_selects_product
          when "2"
            @current_products = @products
          when "3"
            @current_users_coins = @users_coins
          when "4"
            @current_tills_coins = @tills_coins
          when "X"
            exit
        end
    end
  
    def user_selects_product
        puts "Type the name of your choice:"
        input = gets.chomp.capitalize
        if @products.products.include?(input)
          selected_product = @products.products.select { |product| product == input }
          @payment = Payments.new(selected_product.keys.first, selected_product.values.first, @current_users_coins, @tills_coins)
          @payment.buy
        else
          puts "Invalid input"
          puts "-----------------------------"
          handle_initial_options("1")
        end
    end


    def update_current_products(new_value)
        @current_products = new_value
    end

    def update_current_tills_coins(new_value)
        @current_tills_coins = new_value
    end

    def update_current_users_coins(new_value)
        @current_users_coins = new_value
    end

end
