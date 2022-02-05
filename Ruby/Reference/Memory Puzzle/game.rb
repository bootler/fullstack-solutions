# Memory Puzzle - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/memory-puzzle
# game.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'card'
require_relative 'board'
require_relative 'human_player'

class Game
    def initialize
        @prev_guess = nil
        @board = Board.new
        @board.populate
        @player = HumanPlayer.new
    end

    def play
        until @board.won?
            system("clear")
            @board.render
            make_guess(@player.prompt)
        end
    end

    def make_guess(pos)
        guess, prev = @board.reveal(pos), @prev_guess
        @player.receive_revealed_card(pos, guess.face_value)
        if prev.is_a?(Card)
            unless guess == prev
                system("clear")
                @board.render
                sleep(1)
                guess.hide
                prev.hide
            end
            @prev_guess = nil
        else
            @prev_guess = guess
        end
    end
            
    def show
        @board.render
    end
end