# Chess (Part Three) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-three-
# queen.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'piece'
require_relative 'modules/slideable'

class Queen < Piece
include Slideable

    def symbol
        '♛'
    end

    def move_dirs
        orthoganal_dirs + diagonal_dirs
    end
end