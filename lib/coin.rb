class Coin

    attr_accessor :type, :value

    def initialize(coin)
        @type = coin
        @value = Coin.available_coins[@type]
    end

    def self.available_coins
        {
            "1p" => 1,
            "2p" => 2,
            "5p" => 5,
            "10p" => 10,
            "20p" => 20,
            "50p" => 50,
            "£1" => 100,
            "£2" => 200
        }
    end

    # def validate_value
    #     if Coin.available_coins.keys.include? @coin
    #         @value = Coin.available_coins[@coin]
    #     elsif Coin.available_coins.values.include? @value
    #         @value = Coin.available_coins.keys[@value]
    #     else 
    #         nil
    #     end
    # end
end