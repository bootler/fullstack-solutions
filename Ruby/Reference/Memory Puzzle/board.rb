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

    def initialize
        @grid = Array.new(4) { Array.new(4, nil) }
        @size = @grid.length
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
        puts
        range = (0...@size).to_a
        puts "  #{range.join(" ")}"
        range.each do |row|
            puts "#{row} #{@grid[row].join(" ")}"
        end
        puts
    end

    def reveal(guessed_pos)
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

    def full_grid?
        grid.none? do |row|
            row.none? { |col| col == nil }
        end
    end

    def get_positions
        positions = []
        @grid.each_index do |row|
            @grid[row].each_index { |col| positions << [row, col] }
        end
        positions
    end

    def get_card_pool
        num_cards = (@size**2) / 2
        cards = {}
        num_cards.times do
            free_cards = FACE_VALUES.reject { |card| cards.keys.include?(card) }
            picked = free_cards[rand(free_cards.length - 1)]
            cards[picked] = 2
        end
        cards
    end
end