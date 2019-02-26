class DisplayOptions

    def initial_options
        puts "What would you like to do?"
        options = { '1' => 'Choose a snack', 'X' => 'Exit' }
        options.each do |indicator, option|
          puts "(#{indicator}) #{option}"
        end
    end
end