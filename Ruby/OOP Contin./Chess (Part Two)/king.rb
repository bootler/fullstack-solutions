# Chess (Part Two) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-two-
# king.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'piece'
require_relative 'modules/stepable'

class King < Piece
    include Stepable

    def symbol
        '♚'
    end

    def move_diffs
        [
            [1, 0],
            [-1, 0],
            [0, 1],
            [0, -1],
            [-1, 1],
            [1, -1],
            [-1, -1],
            [1, 1]
        ]
    end
end