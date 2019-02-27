class UsersMoney
    attr_accessor :users_coins

    def initialize(users_coins)
        @users_coins = users_coins
    end

    def list_coins
        puts "You have:"
        puts @users_coins.join(" ")
        print "\n"
    end

    def remove_users_paid_coins(input)
        input.each { |coin| users_coins.delete(coin)}
        users_coins
    end
end