# Chess (Part Two) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-two-
# board.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'piece'
require_relative 'null_piece'
require_relative 'rook'
require_relative 'knight'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'pawn'

class Board
    attr_reader :rows, :null_piece

    def initialize
        @null_piece = NullPiece.instance
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

    def empty?(pos)
        self[pos].empty?
    end
        
    def move_piece(color, start_pos, end_pos)
        raise "No piece to move at #{start_pos}" unless self[start_pos]
        raise "Target square is not on the board" unless valid_square?(end_pos) 
        raise "You may only move a piece of your own color!" unless self[start_pos].color == color
        self[end_pos] = self[start_pos]
        self[start_pos] = @null_piece
        self[end_pos]
    end

    def valid_square?(pos)
        pos.all? { |coord| coord.between?(0, @rows.length - 1) }
    end

    private

    def setup_board
        grid = Array.new(8,nil)
        (0...grid.length).each do |i|
            case i
            when 0
                grid[i] = home_row(:black)
            when 1
                grid[i] = pawn_row(:black)
            when 2..5
                grid[i] = Array.new(8, @null_piece)
            when 6
                grid[i] = pawn_row(:white)
            when 7
                grid[i] = home_row(:white)
            else
            end
        end
        grid
    end

    def home_row(color)
        color == :white ? y = 7 : y = 0
        [
            Rook.new(color, self, [y,0]),
            Knight.new(color, self, [y, 1]),
            Bishop.new(color, self, [y, 2]),
            Queen.new(color, self, [y, 3]),
            King.new(color, self, [y, 4]),
            Bishop.new(color, self, [y, 5]),
            Knight.new(color, self, [y, 6]),
            Rook.new(color, self, [y, 7])
        ]
    end

    def pawn_row(color)
        color == :white ? y = 6 : y = 1
        Array.new(8) { |i| Pawn.new(color, self, [y, i]) }
    end
end