# Chess (Part Two) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-two-
# piece.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Piece
    attr_reader :color, :board, :pos

    def initialize(color, board, pos)
        @color = color
        @board = board
        @pos = pos
    end

    def to_s
        " #{symbol} ".colorize(color)
    end

    def empty?
        false
    end

    def valid_moves
    end

    def pos=(val)
        @pos = val
    end

    def symbol
    end

    private
    
    def move_into_check?(end_pos)
    end
end