class Product

    attr_reader :name, :price, :value

    def initialize(product)
        @name = product[0]
        @price = product[1].keys
        @value = product[1].values
    end

end
