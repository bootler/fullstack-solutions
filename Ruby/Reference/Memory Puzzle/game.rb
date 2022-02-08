# Memory Puzzle - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/memory-puzzle
# game.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'card'
require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
    def initialize
        @prev_guess = nil
        @board = Board.new
        @board.populate
        @player = ComputerPlayer.new(4)
    end

    def play
        until @board.won?
            system("clear")
            @board.render
            make_guess(@player.prompt)
        end
        @board.render
    end

    def make_guess(pos)
        guess, prev = @board.reveal(pos), @board.reveal(@prev_guess)
        @player.receive_revealed_card(pos, guess.face_value)
        if is_match?(guess, prev)
            @player.receive_match(pos, @prev_guess)
            @prev_guess = nil
        else
            if prev
                system("clear")
                @board.render
                sleep(1)
                guess.hide
                prev.hide
                @prev_guess = nil
            else
                @prev_guess = pos
            end
        end
    end

    def is_match?(guess, prev)
        return false unless guess && prev
        guess == prev
    end
            
    def show
        @board.render
    end
end