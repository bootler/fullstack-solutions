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
    def initialize(size, match_req)
        @guesses = []
        @match_req = match_req
        @prev_guess = nil
        @board = Board.new(size, match_req)
        @board.populate
        @player = ComputerPlayer.new(size, match_req)
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
        @guesses << pos
        val = @board.reveal(pos).face_value
        @player.receive_revealed_card(pos, val)
        if is_match?(@guesses)
            if @guesses.length % @match_req == 0
                @player.receive_match(@guesses)
                @guesses = []
                update(true)
            end
        else
            update(false)
            @guesses.each { |pos| @board.hide(pos) }
            @guesses = []
        end
    end

    def is_match?(guesses)
        cards = guesses.map { |guess| @board.reveal(guess) }
        cards.all? { |card| card == cards[0] }
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
    match_x = ARGV[1].to_i > 1 ? ARGV[1].to_i : 2
    unless size % match_x == 0
        puts "Board size adjusted to fit an even number of matches"
        until size % match_x == 0
            size += 1
        end
    end
    Game.new(size, match_x).play
end
