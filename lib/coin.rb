class Coin

    attr_reader :type, :value

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

end
