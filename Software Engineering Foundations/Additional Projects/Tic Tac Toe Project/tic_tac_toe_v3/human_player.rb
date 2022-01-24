# Tic Tac Toe Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/tictactoe-project
# human_player.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class HumanPlayer
    attr_reader :mark

    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position(legal_positions)
        pos = ""
        loop do
            puts "Player " + @mark.to_s + ". please choose a square by inputting a row and column number"
            puts "Valid examples: 1 1 | 0 2 | 2 1 | etc."
            begin
                pos = gets.chomp.split
                if pos.length != 2
                    raise "Too few/too many values entered, please enter 2 numbers separated by a space" 
                end
                if pos.any? { |str| str.to_i.to_s != str } # so bizarre but to_i converts NaN to 0 and doesn't raise exception.
                    raise "Invalid characters, please enter valid numbers"
                end
                pos.map!(&:to_i)
                break if legal_positions.any? { |el| el == pos }
                puts "Illegal position, please try again."
            rescue => e
                puts e.message
                next
            end
        end
        pos
    end
end
