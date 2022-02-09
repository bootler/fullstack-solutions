# Sudoku - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/sudoku
# game.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'board'

class Game
    def initialize(filename)
        from_file = Board.from_file(filename)
        @board = Board.new(from_file)
    end

    def prompt
        puts "Please enter a position and value in the form 'row column value'"
        input = gets.chomp.split.map(&:to_i)
        input
    end

    def play
        until @board.solved?
            refresh
            @board.update_tile(*prompt)
        end
        refresh
        puts "You win!"
    end

    def refresh
        system("clear")
        @board.render
    end
end

IF __FILE__ == $PROGRAM_NAME
    Game.new('./static/sudoku1.txt').play
end