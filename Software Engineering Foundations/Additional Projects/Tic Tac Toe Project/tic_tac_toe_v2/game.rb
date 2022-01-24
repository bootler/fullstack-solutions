# Tic Tac Toe Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/tictactoe-project
# game.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative "./board.rb"
require_relative "./human_player.rb"

class Game
    def initialize(board_size, *player_marks)
        @board = Board.new(board_size)
        @players = player_marks.map { |mark| HumanPlayer.new(mark) }
        @current_player = @players[0]
    end

    def switch_turn
        cp_index = @players.index(@current_player)
        @current_player = @players[(cp_index + 1) % @players.length]
    end

    def play
        while @board.empty_positions?
            @board.print
            begin
                pos = @current_player.get_position
                if @board.empty?(pos)
                    @board.place_mark(pos, @current_player.mark)
                    if @board.win?(@current_player.mark)
                        @board.print
                        puts "Player "+@current_player.mark.to_s+", you win!"
                        return
                    end  
                    self.switch_turn
                else
                    puts "Square is either filled or out of bounds, please choose another"
                    puts
                end
            rescue => e
                puts e.message
                puts "Please review the error message and try again"
                puts
            end
        end
        @board.print
        puts "No more moves. The game is a draw."
    end
end



