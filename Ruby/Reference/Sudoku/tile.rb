# Sudoku - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/sudoku
# tile.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require 'colorize'

class Tile
    attr_reader :value, :given

    def initialize(value, given)
        @value = value
        @given = given
    end

    def value=(val)
        @value = val unless @given
    end

    def to_s
        return " " if @value == 0
        if @given
            return "#{@value}".colorize(:magenta)
        else
            return "#{@value}".colorize(:light_blue)
        end
    end
end
