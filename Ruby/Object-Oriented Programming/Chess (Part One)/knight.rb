# Chess (Part One) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-one-
# knight.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'piece'
require_relative 'modules/stepable'

class Knight < Piece
    include Stepable
    
    def symbol
        '♞'
    end

    def move_diffs
        [
            [-2, -1],
            [2, 1],
            [-2, 1],
            [2, -1],
            [-1, -2],
            [-1, 2],
            [1, -2],
            [1, 2]
        ]
    end
end