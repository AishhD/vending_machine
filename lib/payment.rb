class Payments 

    def initialize(item, price, current_users_coins, tills_coins)
        @item = item
        @price = price
        @current_users_coins = current_users_coins
        @total = 0
        @tills_coins = tills_coins
        @coins = Coins.new()
    end

    def buy
        @current_users_coins.list_coins
        puts "Please pay #{@price.keys[0]} in coins"
        user_payments
    end 

    def user_payments
        @input = gets.chomp
        @input.tr!(',', '')
        @input = @input.split(" ")
        validate_input
    end

    def validate_input
        if (!@input.all? { |coin| @coins.available_coins.include? (coin)})
            puts "Invalid input"
            puts "-----------------------------"
            buy
        else
            @input_value = @input.map { |coin| @coins.available_coins[coin] }
            puts check_paid_amount
        end
    end

    def check_paid_amount
        @total = @input_value.reduce(@total) { |sum, num| sum + num}
        price = @price.values[0]
        remainder = price - @total
        if @total < price
            # @current_users_coins.users_coins = @current_users_coins.remove_users_paid_coins(@input)
            puts @current_users_coins.users_coins
            puts "You have paid #{@total}p, please pay the remaining #{remainder}p"
        elsif @total == @price
           
        elsif @total > price
            @change = Change.new(@input, @total, @item, @tills_coins, @price)
            @change.give_change
        else 
            puts "invalid"
        end
    end

end