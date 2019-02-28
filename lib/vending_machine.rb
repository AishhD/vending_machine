class VendingMachine

    attr_accessor :products, :vending_machine_coins, :selected_product

    def initialize(products, vending_machine_coins)
        @products = products.map { |product| Product.new(product)}
         #an array of coin class instances organised from highest to lowest value
        @vending_machine_coins = vending_machine_coins.map { |coin| Coin.new(coin)}.sort_by {|coin| coin.value}.reverse
    end

    def vend_product(input)
        @selected_product = @products.find { |product| product.name == input }
    end

    def list_products
        puts "Our products are:"
        @products.map { |product, price| "#{product.name}, #{product.price[0]}" }
    end

    def list_selected_product
        puts "For #{@selected_product.name} please pay #{@selected_product.price[0]} in coins"
    end

    def remove_product(selected_product)
        @products = @products - @products.select{|product| product == selected_product}
    end

    def remove_vending_machine_coin(remove_coin)
        @vending_machine_coins = @vending_machine_coins - @vending_machine_coins.select{|coin| coin == remove_coin}
    end

    def main_menu_options
        puts "What would you like to do?"
        options = { '1' => 'Choose a snack', '2' => 'Reset your balance', '3' => 'Reset vending machine', 'X' => 'Exit' }
        options.each do |indicator, option|
        puts "(#{indicator}) #{option}"
        end
    end

end
