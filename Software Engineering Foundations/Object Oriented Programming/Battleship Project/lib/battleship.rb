# Battleship Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/battleship-project
# battleship.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative "board"
require_relative "player"

class Battleship
    attr_reader :board, :player
    
    def initialize(n)
        @player = Player.new
        @board = Board.new(n)
        @remaining_misses = (@board.size / 2).truncate
    end

    def start_game
        @board.place_random_ships
        puts @board.num_ships
        @board.print
    end

    def lose?
        if @remaining_misses <= 0
            puts 'you lose'
            return true
        else
            return false
        end
    end

    def win?
        if @board.num_ships == 0
            puts "you win"
            return true
        else
            return false
        end
    end

    def game_over?
        return true if win? || lose?
        return false
    end

    def turn
        @remaining_misses -= 1 if !@board.attack(@player.get_move)
        @board.print
        puts @remaining_misses
    end
end
