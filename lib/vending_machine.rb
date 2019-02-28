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

    def remove_product(selected_product)
        @products = @products - @products.select{|product| product == selected_product}
    end

    def remove_vending_machine_coin(remove_coin)
        @vending_machine_coins = @vending_machine_coins - @vending_machine_coins.select{|coin| coin == remove_coin}
    end

end
