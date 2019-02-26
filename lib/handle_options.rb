class HandleOptions

    def initialize(products)
      @products = products
    end

    def exit 
      abort("Goodbye")
    end

    def display_initial_options
        puts "What would you like to do?"
        options = { '1' => 'Choose a snack', 'X' => 'Exit' }
        options.each do |indicator, option|
          puts "(#{indicator}) #{option}"
        end
    end

    def handle_initial_options(input=nil)
      if (!input)
        input = gets.chomp.capitalize
      end
      case input 
        when "1"
          puts @products.list_products
          user_selects_product
        when "X"
          exit
      end
    end

    def user_selects_product
      puts "Type the name of your choice:"
      input = gets.chomp.capitalize
      if @products.products.include?(input) 
      
      else
        puts "Invalid input"
        handle_initial_options("1")
      end
    end
    
end