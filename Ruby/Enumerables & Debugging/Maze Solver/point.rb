# Maze Solver - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/maze-solver--bonus-
# point.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Point
    attr_accessor :x, :y, :val, :f, :g, :h

    def initialize(x, y, val)
        @x = x
        @y = y
        @val = val
        @f = 0
        @g = 0
        @h = 0
    end

    # def inspect
    #     "#{@x}, #{@y}, #{@val}"
    # end

    def print
        Kernel.print(@val)
    end

    def to_a
        [@x, @y, @val]
    end

    def update(val)
        @val = val
    end

    def ==(point)
        return false if !point
        @x == point.x && @y == point.y
    end
end
