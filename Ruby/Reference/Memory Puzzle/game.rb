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
    def initialize(size)
        @prev_guess = nil
        @board = Board.new(size)
        @board.populate
        @player = ComputerPlayer.new(size)
    end

    def play
        until @board.won?
            show
            make_guess(@player.prompt)
        end
        show
        puts "You win!"
    end

    def make_guess(pos)
        guess, prev = @board.reveal(pos), @board.reveal(@prev_guess)
        @player.receive_revealed_card(pos, guess.face_value)
        if is_match?(guess, prev)
            @player.receive_match(pos, @prev_guess)
            @prev_guess = nil
            update(true)
        else
            if prev
                update(false)
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
        system("clear")
        @board.render
    end

    def update(match)
        show
        if match
            print "It's a match!"
        else
            print "Sorry, try again!"
        end
        sleep(1)
    end
end

if __FILE__ == $PROGRAM_NAME
    size = ARGV[0].to_i > 0 ? ARGV[0].to_i : 4
    unless size % 2 == 0
        puts "Board size adjusted to fit an even number of matches"
        size += 1
    end
    Game.new(size).play
end
