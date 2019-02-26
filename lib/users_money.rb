class UsersMoney
    attr_accessor :users_coins

    def initialize(users_coins)
        @users_coins = users_coins
    end

    def users_coins
        @users_coins
    end

    def list_coins
        puts "You have:"
        @users_coins.each { |coin| print "#{coin}, " }
        print "\n"
        print "\n"
    end
end