# Maze Solver - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/maze-solver--bonus-
# point.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Point
    attr_accessor :x, :y, :val, :parent, :f, :g

    def initialize(x, y, val)
        @x = x
        @y = y
        @val = val
        @parent = nil
        @f = 0
        @g = 0
    end

    def to_a
        [@x, @y, @val]
    end

    def ==(point)
        return false if !point
        @x == point.x && @y == point.y
    end
end
