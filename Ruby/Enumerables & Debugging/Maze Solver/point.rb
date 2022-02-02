# Maze Solver - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/maze-solver--bonus-
# point.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Point
    attr_reader :x, :y, :val

    def initialize(x, y, val)
        @x = x
        @y = y
        @val = val
    end

    def inspect
        "#{@x}, #{@y}, #{@val}"
    end

    def print
        Kernel.print(@val)
    end

    def update(val)
        @val = val
    end
end
