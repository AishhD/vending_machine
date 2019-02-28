require_relative '../lib/coin'

describe Coin do
    let(:new_coin) {Coin.new("£1")}

    it 'initializes a new coin with the correct type' do
        expect(new_coin.type).to eq "£1"
    end

    it 'initializes a new coin with the correct value' do
        expect(new_coin.value).to eq 100
    end

end