require_relative '../lib/product'

describe Product do
    let(:new_product) {Product.new(["Mars",
    {"50p"=>50}])}

    it 'initializes a new product with the correct name' do
        expect(new_product.name).to eq "Mars"
    end

    it 'initializes a new product with the correct price' do
        expect(new_product.price[0]).to eq "50p"
    end

    it 'initializes a new product with the correct value' do
        expect(new_product.value[0]).to eq 50
    end

end
