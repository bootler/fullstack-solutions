# Chess (Part One) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-one-
# rook.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'piece'
require_relative 'modules/slideable'

class Rook < Piece
include Slideable

    def symbol
        '♜'
    end

    def move_dirs
        orthoganal_dirs
    end
end
