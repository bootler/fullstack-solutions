# Maze Solver - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/maze-solver--bonus-
# maze.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'point'

class Maze
    DIRECTIONS = [[1,1], [1,0], [0,1], [-1,0], [0, -1], [-1, -1]]
    attr_reader :maze, :map

    def initialize
        @maze = read_maze("./static/maze1.txt")
        @map = create_map(@maze)
        @bounds = get_bounds
    end

    def print_maze
        # cur_x = 0
        # @map.each do |point|
        #     if point.x > cur_x
        #         cur_x = point.x
        #         puts
        #     end
        #     point.print
        # end
        @maze.each { |line| puts line.join }
        true
    end

    def read_maze(filename)
        grid = []
        File.foreach(filename) { |line| grid << line.chomp.split("") }
        grid
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

    def in_bounds?(point)
        x, y = *@bounds
        point.x >= 0 && point.x <= x && point.y >= 0 && point.y <= y
    end 

    def is_wall?(point)
        point.val == '*'
    end

    def is_path?(point)
        point.val == 'X'
    end

    def get_bounds
        x = @maze.max { |row| row.length }.length - 1
        y = @maze.length - 1
        [x, y]
    end
    
    def get_neighbours(point)
        nbrs = []
        x, y = point.x, point.y
        DIRECTIONS.each do |dir|
            dx, dy = *dir
            nbr = find_point(x + dx, y + dy)
            if nbr && !is_wall?(nbr) && !is_path?(nbr)
                nbrs << nbr
            end
        end
        nbrs
    end

    def update(point)
        x, y, val = *point.to_a
        maze[y][x] = val
    end
end
    