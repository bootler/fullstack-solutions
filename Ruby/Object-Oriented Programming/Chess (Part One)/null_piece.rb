# Chess (Part One) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-one-
# null_piece.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require 'singleton'
require_relative 'piece'

class NullPiece < Piece
    include Singleton

    def initialize
    end

    def moves
        []
    end
    
    def empty?
        true
    end

    def symbol
        " "
    end
end