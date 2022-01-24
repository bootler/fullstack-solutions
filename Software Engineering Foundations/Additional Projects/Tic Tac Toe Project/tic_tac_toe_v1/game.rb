require_relative "./board.rb"
require_relative "./human_player.rb"

class Game
    def initialize(player_1_mark, player_2_mark)
        @board = Board.new
        @player_1 = HumanPlayer.new(player_1_mark)
        @player_2 = HumanPlayer.new(player_2_mark)
        @current_player = @player_1
    end

    def switch_turn
        if @current_player == @player_1
            @current_player = @player_2
        else
            @current_player = @player_1
        end
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
                end
            rescue => e
                puts e.full_message
                puts "Please review the error message and try again"
                puts
            end
        end
        puts "No more moves. The game is a draw."
    end
end



