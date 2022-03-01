# Chess (Part Three) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-three-
# game.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'display'
require_relative 'board'
require_relative 'human_player'

class Game
    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @player_1 = HumanPlayer.new(:white, @display)
        @player_2 = HumanPlayer.new(:black, @display)
        @current_player = @player_1
    end

    def play
        until @board.checkmate?(:white) || @board.checkmate?(:black)
            @current_player.make_move(@board)
            @current_player = next_player
        end
        notify_players
    end

    def next_player
        @current_player.color == :white ? @player_2 : @player_1
    end

    private

    def notify_players
        system("clear")
        @display.render
        if @board.checkmate?(:black)
            puts "1 - 0"
            puts "Checkmate. White is victorious."
        else
            puts "0 - 1"
            puts "Checkmate. Black is victorious."
        end
    end
end

if __FILE__ == $PROGRAM_NAME
    p String.color_samples
    gets
    Game.new.play
end