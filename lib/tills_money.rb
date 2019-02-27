class TillsMoney
    attr_accessor :tills_coins

    def initialize(tills_coins)
        @tills_coins = tills_coins
        @coins = Coins.new()
    end

    def tills_coins
        @tills_coins
    end

    def till_coins_value
        @tills_coins.map { |coin| @coins.available_coins[coin]}.sort.reverse!
    end

end