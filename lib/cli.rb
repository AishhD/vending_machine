class Cli

    # needed just for testing
    attr_reader :initial_arguments, :users_coins, :vending_machine

    def initialize(users_coins, products, vending_machine_coins)
        #saved initial input to reset values
        @initial_arguments = [users_coins, products, vending_machine_coins]
        #an array of coin class instances organised from highest to lowest value
        @users_coins = users_coins.map { |coin| Coin.new(coin)}.sort_by {|coin| coin.value}.reverse
        @vending_machine = VendingMachine.new(products, vending_machine_coins)
    end

    def run
        greet
        #run until no products are in the vending machine
        until vending_machine_empty?
            serve_customer
        end
        puts "No more products, goodbye"
    end

    def vending_machine_empty?
        @vending_machine.products.length == 0
    end

    def greet
        puts "Welcome to the vending machine"
    end

    def display_divider
        puts "------------------------------------"
    end

    def exit
        abort("Goodbye")
    end

    def serve_customer
        @vending_machine.list_available_products
        display_divider
        list_user_coins
        @vending_machine.display_main_menu_options
        handle_menu_choice
    end

    def list_user_coins
        users_available_coins = @users_coins.map {|coin| coin.type}.join(" ")
        puts "You have:"
        puts users_available_coins
        display_divider
    end

    def handle_menu_choice(input=nil)
        #While the method is called with no input get the input from the user.
        while (!input)
          input = gets.chomp.capitalize
        end
        case input
          when "1"
            @vending_machine.list_available_products
            user_selects_product
          when "2"
            reset_users_coins
          when "3"
            reset_vending_machine
          when "X"
            exit
        end
    end

    def reset_users_coins
        #call new instances of Coin class with original input
        @users_coins = @initial_arguments[0].map { |coin| Coin.new(coin)}.sort_by {|coin| coin.value}.reverse
    end

    def reset_vending_machine
        #call new instances of VendingMachine class with original input
        @vending_machine = VendingMachine.new(@initial_arguments[1], @initial_arguments[2])
    end

    def invalid_input
        puts "Invalid input"
        display_divider
    end

    def user_selects_product
        puts "Type the name of the product you wish to buy"
        input = gets.chomp.capitalize
        product = @vending_machine.products.find { |product| product.name == input}
        if product
            #select the product that matches the input and return the product not in an array
            @vending_machine.selected_product = product
            @vending_machine.set_initial_remainder_to_pay
            start_buy_phase
        else
            invalid_input
            handle_menu_choice("1")
        end
    end

    def start_buy_phase
        list_user_coins
        @vending_machine.show_product_price
        handle_payment
    end

    def handle_payment
        @input = gets.chomp
        @input.tr!(',', '')
        @input = @input.split(" ")
        validate_input
    end

    def validate_input
        available_coins = @users_coins.map{|coin| coin.type}
        check_if_user_has_coin = @input.find { |coin| available_coins.include? (coin) }
        #if the user doesn't have the coin
        if (!check_if_user_has_coin)
            puts "Invalid input"
            puts "-----------------------------"
            #rerun buy phase
            start_buy_phase
        else
            set_paid_amount
            remove_users_paid_coins
            check_user_paid_enough
        end
    end

    def set_paid_amount
        #map each coin given, find that coin in the users coins and return its value
        values_of_users_payment = @input.map { |coin| @users_coins.find {|user_coin| user_coin.type == coin}.value }
        @vending_machine.paid_value = values_of_users_payment
    end
    
    def check_user_paid_enough
        @vending_machine.set_remainder_to_pay
        if @vending_machine.remainder_to_pay > 0
            @vending_machine.request_more_money
            list_user_coins
            handle_payment
        elsif @vending_machine.remainder_to_pay == 0
            @vending_machine.remove_product(@vending_machine.selected_product)
            @vending_machine.give_product
            @vending_machine.reset_total_amount_paid
        elsif @vending_machine.remainder_to_pay < 0
            @vending_machine.remove_product
            @vending_machine.give_change
            modify_users_coins
            @vending_machine.return_product_and_change
            @vending_machine.reset_total_amount_paid
        else
            puts "Invalid amount entered"
        end
    end

    def remove_users_paid_coins
        @input.each {|coin| @users_coins = @users_coins - @users_coins.select{|users_coin| users_coin.type == coin} }
    end

    def modify_users_coins
        @vending_machine.coins_to_return.each do |coin|
            @users_coins << coin
            @users_coins.sort_by! {|coin| coin.value}.reverse!
        end
    end

end
