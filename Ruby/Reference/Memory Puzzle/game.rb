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
        @board = Board.new(size, match_req)
        @board.populate
        @bombed = false
        @guesses = []
        @match_req = match_req
        @player = HumanPlayer.new(size, match_req)
    end

    def begin
        show
        @board.hide_bombs
        puts "Be careful not to uncover these bombs by mistake!"
        sleep(5)
        play
    end

    def play
        until @board.won? || @bombed
            show
            make_guess(@player.prompt)
        end
        notify_result
    end

    def make_guess(pos)
        @guesses << pos
        card = @board.reveal(pos)
        if card.bomb
            @bombed = true
            return
        end

        @player.receive_revealed_card(pos, card.face_value)
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
    
    def notify_result
        @board.reveal_bombs
        show
        if @bombed
            puts "You uncovered a bomb! Better luck next time."
        else
            puts "You win!"
        end
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
    Game.new(size, match_x).begin
end
