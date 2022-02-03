# Maze Solver - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/maze-solver--bonus-
# maze.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'point'
require 'set'

class Maze
    DIRECTIONS = [[1,1], [1,0], [0,1], [-1,0], [0, -1], [-1, -1]]

    def initialize(filename)
        @maze = read_maze(filename)
        @map = create_map(@maze)
    end

    def print_maze
        @maze.each { |line| puts line.join }
        true
    end

    def read_maze(filename)
        maze = []
        File.foreach(filename) { |line| maze << line.chomp.split("") }
        maze
    end

    def create_map(maze)
        map = Set.new
        maze.each_index do |y|
            maze[y].each_index { |x| map << Point.new(x, y, maze[y][x]) }
        end
        map
    end

    def find_start
        @map.select { |point| point.val == 'S' }[0]
    end

    def find_end
        @map.select { |point| point.val == 'E' }[0]
    end

    def find_point(x,y)
        @map.select { |point| point.x == x && point.y == y }[0]
    end

    def is_wall?(point)
        point.val == '*'
    end

    def get_neighbours(point)
        nbrs = []
        x, y = point.x, point.y
        DIRECTIONS.each do |dir|
            dx, dy = *dir
            nbr = find_point(x + dx, y + dy)
            if nbr && !is_wall?(nbr)
                nbrs << nbr
            end
        end
        nbrs
    end

    def update(point)
        x, y, val = *point.to_a
        @maze[y][x] = val
    end
end
    