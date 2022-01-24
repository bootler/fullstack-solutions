require_relative "./board.rb"
require_relative "./human_player.rb"
require_relative "./computer_player.rb"

class Game
    def initialize(board_size, **player_details)
        @board = Board.new(board_size)
        @players = player_details.keys.map do |mark|
            if player_details[mark] # hash values are boolean, true = computer, false = human
                ComputerPlayer.new(mark)
            else
                HumanPlayer.new(mark)
            end
        end
        @current_player = @players[0]
    end

    def switch_turn
        cp_index = @players.index(@current_player)
        @current_player = @players[(cp_index + 1) % @players.length]
    end

    def play
        while @board.empty_positions?
            @board.print
            pos = @current_player.get_position(@board.legal_positions)
            @board.place_mark(pos, @current_player.mark)
            if @board.win?(@current_player.mark)
                @board.print
                puts "Player "+@current_player.mark.to_s+", you win!"
                return
            end  
            self.switch_turn
        end
        @board.print
        puts "No more moves. The game is a draw."
    end
end



