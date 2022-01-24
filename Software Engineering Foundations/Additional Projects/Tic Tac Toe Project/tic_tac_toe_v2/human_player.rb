class HumanPlayer
    attr_reader :mark

    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position
        puts "Player " + @mark.to_s + ". please choose a square by inputting a row and column number"
        puts "Valid examples: 1 1 | 0 2 | 2 1 | etc."
        pos = gets.chomp.split
        if pos.length != 2
            raise "Too few/too many values entered, please enter 2 numbers separated by a space" 
        end
        if pos.any? { |str| str.to_i.to_s != str } # so bizarre but to_i converts NaN to 0 and doesn't raise exception.
            raise "Invalid characters, please enter valid numbers"
        end
        pos.map(&:to_i)
    end
end
