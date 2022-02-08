# Memory Puzzle - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/memory-puzzle
# computer_player.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class ComputerPlayer
    def initialize(size, match_req)
        @size = size
        @known_cards = {}
        @matched_cards = {}
        @guesses = []
        @positions = setup(@size)
        @match_req = match_req
    end

    def prompt
        sleep(1)
        positions_left = @positions.reject { |pos| @known_cards[pos] }
        if positions_left.length == 0
            positions_left = @positions.reject { |pos| @matched_cards[pos] }
        end
        @guesses = [] if reset_guesses?
        make_guess(positions_left) 
    end

    def receive_revealed_card(pos, value)
        @known_cards[pos] = value
    end

    def receive_match(positions)
        positions.each do |pos|
            @matched_cards[pos] = true
        end
    end

    private

    def make_guess(positions)
        if @guesses.empty?
            @guesses << positions[rand(positions.length - 1)]
            return @guesses[-1]
        end
        known = find_known_match(@guesses[-1])
        if known
            @guesses << known
            return known
        end
        picked = positions[rand(positions.length - 1)]
        @guesses << picked
        picked
    end

    def find_known_match(pos)
        known = @known_cards.reject { |k,v| @guesses.include?(k) || @matched_cards[k] }
        v = known.values.find { |val| @known_cards[pos] == val }
        known.keys.find { |k| known[k] == v}
    end

    def reset_guesses?
        @guesses.length == @match_req || @guesses.length > 1 && @known_cards[@guesses[-1]] != @known_cards[@guesses[-2]]
    end

    def setup(size)
        positions = []
        (0...size).each do |i|
            (0...size).each { |j| positions << [i, j] }
        end
        positions
    end
end
