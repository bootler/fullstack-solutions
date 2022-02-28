# Chess (Part Three) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-three-
# human_player.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'player'

class HumanPlayer < Player
    def make_move(board)
        selected_piece = []
        loop do
            system("clear")
            puts "It is #{@color.to_s.capitalize}'s turn."
            puts "You are in check.".yellow if board.in_check?(@color)
            @display.render
            input = @display.cursor.get_input
            if input
                if @display.cursor.selected
                    selected_piece = input
                else
                    board.move_piece(@color, selected_piece, input)
                    break
                end
            end
        end
        rescue => e
            puts e.message
            puts "Press enter to try again."
            gets
            retry
        end
end