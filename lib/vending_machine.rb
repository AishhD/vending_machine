class VendingMachine

    attr_accessor :selected_product, :paid_value

    attr_reader :total_amount_paid, :products, :vending_machine_coins, :remainder_to_pay, :coins_to_return, :main_menu_options

    def initialize(products, vending_machine_coins)
        @products = products.map { |product| Product.new(product)}
         #an array of coin class instances organised from highest to lowest value
        @vending_machine_coins = vending_machine_coins.map { |coin| Coin.new(coin)}.sort_by {|coin| coin.value}.reverse
        @paid_value = 0
        @total_amount_paid = 0
        @selected_product = nil
    end

    def list_available_products
        products_list = @products.map { |product, price| "#{product.name}, #{product.price[0]}" }.join("\n")
        puts "Our products are: \n#{products_list}"

    end

    def show_product_price
        puts "For #{@selected_product.name} please pay #{@remainder_to_pay} in coins"
    end

    def remove_product
        # find the instance of the selected product in @products
        products_instance_of_selected_product = @products.select{|product| product == @selected_product}
        # remove the instance of the selected product from @products
        @products = @products - products_instance_of_selected_product
    end

    def main_menu_options
        { '1' => 'Choose a snack', '2' => 'Reset your balance', '3' => 'Reset vending machine', 'X' => 'Exit' }
    end

    def display_main_menu_options
        puts "What would you like to do?"
        main_menu_options.each do |indicator, option|
        puts "(#{indicator}) #{option}"
        end
    end

    def set_selected_product_price
        @selected_product_price = @selected_product.value[0]
    end

    def set_total_paid
        @total_amount_paid = @paid_value.reduce(@total_amount_paid) { |sum, num| sum + num}
    end

    def reset_total_amount_paid
        @total_amount_paid = 0
    end

    def set_initial_remainder_to_pay
        @remainder_to_pay = @selected_product.price[0]
    end

    def set_remainder_to_pay
        set_selected_product_price
        set_total_paid
        #remainder_to_pay is the product price minus the total amount paid
        @remainder_to_pay = @selected_product_price - @total_amount_paid
    end

    def request_more_money
        puts "You have paid #{@total_amount_paid}p, please pay the remaining #{@remainder_to_pay}p"
    end

    def give_product
        puts "Please take your #{selected_product.name}"
    end

    def give_change
        coin_values = []
        initial_change_amount_needed = @total_amount_paid - @selected_product_price
        @coins_to_return = []
        change_amount_needed = initial_change_amount_needed
        #Go through each coin in the vending machine
        vending_machine_coins.each do |coin|
            # if the change needed minus the coin is greater than 0
            if ((change_amount_needed - coin.value).to_int > 0)
                coin_values << coin.value
                @coins_to_return << coin
                change_amount_needed = initial_change_amount_needed - coin_values.inject(:+)
                remove_vending_machine_coin(coin)
            end
        end
    end

    def remove_vending_machine_coin(remove_coin)
        @vending_machine_coins = @vending_machine_coins - @vending_machine_coins.select{|coin| coin == remove_coin}
    end

    def coin_types_to_return
        coins_to_return.map {|coin| coin.type}
    end

    def return_product_and_change
        puts "Please take your #{@selected_product.name} and your change: #{coin_types_to_return.join(' ')}"
    end

end
