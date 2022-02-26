# Chess (Part One) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-one-
# board.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'piece'

class Board
    def initialize
        @rows = setup_board
    end

    def[](pos)
        y, x = *pos
        @rows[y][x]
    end

    def []=(pos, val)
        y, x = *pos
        @rows[y][x] = val
    end

    def move_piece(start_pos, end_pos)
        raise "No piece to move at #{start_pos}" unless self[start_pos]
        raise "Target square is not on the board" if end_pos.any? { |axis| axis >= @rows.length }
        self[end_pos] = self[start_pos]
        self[start_pos] = nil
        self[end_pos]
    end

    private

    def setup_board
        grid = Array.new(8,nil)
        (0...grid.length).each do |i|
            if i < 2 || i >= grid.length - 2
                grid[i] = Array.new(8) { Piece.new }
            else
                grid[i] = Array.new(8, nil)
            end
        end
        grid
    end
end