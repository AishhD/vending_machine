class Products
    attr_accessor :products

    def initialize(products)
        @products = products
    end

    def products
        @products
    end

    def list_products
        puts "Our products are:"
        @products.map { |product, price| "#{product}, #{price}" }
    end
end