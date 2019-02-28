class Cli

    attr_accessor :users_coins, :vending_machine, :input_value
    # needed just for testing
    attr_reader :total, :initial_arguments

    def initialize(users_coins, products, vending_machine_coins)
        #saved initial input to reset values
        @initial_arguments = [users_coins, products, vending_machine_coins]
        #an array of coin class instances organised from highest to lowest value
        @users_coins = users_coins.map { |coin| Coin.new(coin)}.sort_by {|coin| coin.value}.reverse
        @vending_machine = VendingMachine.new(products, vending_machine_coins)
        @total = 0
    end

    def run
        greet
        until @vending_machine.products.length === 0
            run_program
        end
        puts "No more products, goodbye"
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

    def run_program
        puts @vending_machine.list_products
        separate
        list_coins
        main_menu_options
        handle_main_menu_options
    end

    def list_coins
        puts "You have:"
        puts @users_coins.map {|coin| coin.type}.join(" ")
        separate
    end

    def main_menu_options
        puts "What would you like to do?"
        options = { '1' => 'Choose a snack', '2' => 'Reset your balance', '3' => 'Reset vending machine', 'X' => 'Exit' }
        options.each do |indicator, option|
        puts "(#{indicator}) #{option}"
        end
    end

    def handle_main_menu_options(input=nil)
        if (!input)
          input = gets.chomp.capitalize
        end
        case input
          when "1"
            puts @vending_machine.list_products
            puts"Type the name of the product you wish to buy"
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

    def user_selects_product
        input = gets.chomp.capitalize
        if @vending_machine.products.any? { |product| product.name == input}
            #select the product that matches the input and return the product not in an array
            @vending_machine.vend_product(input)
            buy
        else
            puts "Invalid input"
            puts "-----------------------------"
            handle_main_menu_options("1")
        end
    end

    def buy
        list_coins
        list_selected_product
        user_payments
    end

    def list_selected_product
        puts "For #{@vending_machine.selected_product.name} please pay #{@vending_machine.selected_product.price[0]} in coins"
    end

    def user_payments
        @input = gets.chomp
        @input.tr!(',', '')
        @input = @input.split(" ")
        validate_input
    end

    def validate_input
        available_coins = @users_coins.map{|coin| coin.type}
        if (!@input.all? { |coin| available_coins.include? (coin)})
            puts "Invalid input"
            puts "-----------------------------"
            buy
        else
            @input_value = @input.map { |coin| @users_coins.find {|user_coin| user_coin.type == coin}.value }
            puts check_paid_amount
        end
    end

    def check_paid_amount
        set_total
        @price = @vending_machine.selected_product.value[0]
        remainder = @price - @total
        if remainder > 0
            remove_user_coin
            puts "You have paid #{@total}p, please pay the remaining #{remainder}p"
            puts list_coins
            user_payments
        elsif remainder == 0
            remove_user_coin
            @vending_machine.remove_product(@vending_machine.selected_product)
            puts "Please take your #{@vending_machine.selected_product.name}"
        elsif remainder < 0
            remove_user_coin
            @vending_machine.remove_product(@vending_machine.selected_product)
            give_change
        else
            puts "Invalid amount entered"
        end
    end

    def set_total
        @total = @input_value.reduce(@total) { |sum, num| sum + num}
    end

    def remove_user_coin
        @input.each {|coin| @users_coins = @users_coins - @users_coins.select{|users_coin| users_coin.type == coin} }
    end

    def give_change
        return_coin_value = []
        return_coin_type = []
        initial_remaining_amount = @total - @price
        remainder = @total - @price
        # counts down finds biggest coins first
        @vending_machine.vending_machine_coins.each do |coin|
            if ((remainder/coin.value).to_int > 0)
                return_coin_value << coin.value
                return_coin_type << coin.type
                modify_users_coins(coin)
                remainder = initial_remaining_amount - return_coin_value.inject(:+)
                @vending_machine.remove_vending_machine_coin(coin)
            end
        end
        return_prodct_and_change(return_coin_type)
    end

    def modify_users_coins(coin)
        @users_coins << coin
        @users_coins.sort_by! {|coin| coin.value}.reverse!
    end

    def return_prodct_and_change(return_coins)
        puts "Please take your #{@vending_machine.selected_product.name} and your change: #{return_coins.join(' ')}"
    end

end
