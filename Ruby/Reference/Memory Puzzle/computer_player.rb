# Memory Puzzle - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/memory-puzzle
# computer_player.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class ComputerPlayer
    def initialize(size)
        @size = size
        @known_cards = {}
        @matched_cards = {}
        @first_guess = nil
        @next_guess = nil
        @positions = setup(@size)
    end

    def prompt
        positions_left = @positions.reject { |pos| @matched_cards[pos] }
        unless @first_guess
            @first_guess = make_first_guess(positions_left)
            return @first_guess
        else
            positions_left.reject! { |pos| pos == @first_guess }
            @first_guess = nil
            return make_second_guess(positions_left)
        end
    end

    def receive_revealed_card(pos, value)
        @known_cards[pos] = value
    end

    def receive_match(pos1, pos2)
        @matched_cards[pos1] = true
        @matched_cards[pos2] = true
    end

    private

    def make_first_guess(positions)
        guess, @next_guess, rest = *find_known_match
        if guess && @next_guess
            return guess
        else
            return positions[rand(positions.length - 1)]
        end
    end

    def make_second_guess(positions)
        guess = @next_guess
        if guess
            @next_guess = nil
            return guess
        else
            return positions[rand(positions.length - 1)]
        end
    end 

    def find_known_match
        known = @known_cards.reject { |k,v| @matched_cards[k] }
        v = known.values.find do |v|
            known.keys.select { |k| known[k] == v}.length >= 2
        end
        known.keys.select { |k| known[k] == v}
    end

    def setup(size)
        positions = []
        (0...size).each do |i|
            (0...size).each { |j| positions << [i, j] }
        end
        positions
    end
end
