require_relative '../lib/vending_machine'

describe VendingMachine do

    set_vending_machine_coins = ["1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2", "1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2", "1p", "2p", "5p", "10p", "20p", "50p", "£1", "£2"]
    set_products = {"Kettle crips" => {"£1" => 100}, "Walkers crips" => {"50p" => 50}, "Popchips" => {"65p" => 65}, "Sensations" => {"£1.50" => 150}, "Quavers" => {"80p" => 80}}

    let(:vending_machine) {VendingMachine.new(set_products, set_vending_machine_coins)}

    it 'initializes with @total_amount_paid at 0' do
        expect(vending_machine.total_amount_paid).to eq 0
    end

    it 'initializes the vending machine with the correct products, price and value' do
        expect(vending_machine.products.map { |product| {product.name => {product.price[0] => product.value[0]}}}).to eq [{"Kettle crips"=>{"£1"=>100}},{"Walkers crips"=>{"50p"=>50}},{"Popchips"=>{"65p"=>65}},{"Sensations"=>{"£1.50"=>150}},{"Quavers"=>{"80p"=>80}}]
    end

    it 'initializes the vending machine with the correct coin type and value' do
        expect(vending_machine.vending_machine_coins.map { |coin| {coin.type => coin.value} }).to eq [{"£2"=>200},
        {"£2"=>200},
        {"£2"=>200},
        {"£1"=>100},
        {"£1"=>100},
        {"£1"=>100},
        {"50p"=>50},
        {"50p"=>50},
        {"50p"=>50},
        {"20p"=>20},
        {"20p"=>20},
        {"20p"=>20},
        {"10p"=>10},
        {"10p"=>10},
        {"10p"=>10},
        {"5p"=>5},
        {"5p"=>5},
        {"5p"=>5},
        {"2p"=>2},
        {"2p"=>2},
        {"2p"=>2},
        {"1p"=>1},
        {"1p"=>1},
        {"1p"=>1}]
    end

    it 'list_products to puts "Our products are:"' do
        expect{vending_machine.list_available_products}.to output("Our products are: \nKettle crips, £1\nWalkers crips, 50p\nPopchips, 65p\nSensations, £1.50\nQuavers, 80p\n").to_stdout
    end

    it 'removes a product' do
        vending_machine.selected_product = vending_machine.products.first
        expect((vending_machine.remove_product).map{|product| product.name}).to eq ["Walkers crips", "Popchips", "Sensations", "Quavers"]
    end

    it 'removes a coin' do
        expect(vending_machine.remove_vending_machine_coin(vending_machine.vending_machine_coins.first).map{|coin| coin.type}).to eq ["£2", "£2", "£1", "£1", "£1", "50p", "50p", "50p", "20p", "20p", "20p", "10p", "10p", "10p", "5p", "5p", "5p", "2p", "2p", "2p", "1p", "1p", "1p"]
    end

    it 'has all the menu options' do
        expect(vending_machine.main_menu_options).to eq ({"1"=>"Choose a snack", "2"=>"Reset your balance", "3"=>"Reset vending machine", "X"=>"Exit"})
    end

    it 'set_total adds up the input value' do
        vending_machine.paid_value = [1, 2, 3]
        expect(vending_machine.set_total_paid).to eq 6
    end

end
