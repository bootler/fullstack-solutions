# Memory Puzzle - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/memory-puzzle
# board.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'card'

class Board
    attr_accessor :grid
    FACE_VALUES = (:A..:Z).to_a

    def initialize(size, match_req)
        @grid = Array.new(size) { Array.new(size, nil) }
        @size = @grid.length
        @match_req = match_req
    end

    def populate
         card_pool = get_card_pool
         positions = get_positions
         positions.each do |pos|
            row, col = *pos
            cards_left = card_pool.keys.select { |k| card_pool[k] > 0 }
            face = cards_left[rand(cards_left.length - 1)]
            card = Card.new(face, false)
            @grid[row][col] = card
            card_pool[face] -= 1
         end
         true
    end

    def render
        range = (0...@size).to_a
        puts "  #{range.join(" ")}"
        range.each do |row|
            puts "#{row} #{@grid[row].join(" ")}"
        end
        puts
    end

    def hide(guessed_pos)
        return nil unless guessed_pos
        row, col = *guessed_pos
        slot = @grid[row][col]
        if slot.is_a?(Card)
            slot.hide
        end
        nil
    end

    def reveal(guessed_pos)
        return nil unless guessed_pos
        row, col = *guessed_pos
        slot = @grid[row][col]
        if slot.is_a?(Card)
            slot.show
            return slot
        end
        nil
    end

    def won?
        @grid.all? do |row|
            row.all? { |card| card.revealed }
        end
    end

    private

    def get_positions
        positions = []
        @grid.each_index do |row|
            @grid[row].each_index { |col| positions << [row, col] }
        end
        positions
    end

    def get_card_pool
        num_cards = (@size**2) / @match_req
        max_pairs = @match_req * deck_mult(num_cards)
        cards = Hash.new(0)
        num_cards.times do
            free_cards = FACE_VALUES.reject { |card| cards[card] >= max_pairs }
            picked = free_cards[rand(free_cards.length - 1)]
            cards[picked] += @match_req
        end
        cards
    end

    def deck_mult(pairs)
        deck = FACE_VALUES.length
        mult = 1
        until deck * mult > pairs
            mult += 1
        end
        mult
    end
end