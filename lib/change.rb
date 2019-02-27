class Change

    def initialize(input, total, item, tills_coins, price)
        @input = input
        @total = total
        @item = item
        @tills_coins = tills_coins
        @coins = Coins.new()
        @price = price
    end

    def give_change
        till_coins_value = @tills_coins.till_coins_value
        # holds list of coins to return
        price = @price.values.first
        return_coin_value = []
        initial_remaining_amount = @total - price
        remaining_amount = @total - price
        # counts down finds biggest coins first
        till_coins_value.each do |coin|
            if ((remaining_amount/coin).to_int > 0)
                then (remaining_amount/coin).to_int.times { return_coin_value << coin }
                # coins.inject(:+) sums array items
                remaining_amount = initial_remaining_amount - return_coin_value.inject(:+)
                ####remove coins from tills coins#########
            end                         
        end
        value_to_coin(return_coin_value)
    end

    def value_to_coin(coin_values)
        return_coins = coin_values.map { |value| @coins.available_coins.key(value) }
        puts "Please take your #{@item} and your change: #{return_coins.join(' ')}"
    end
end