# Maze Solver - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/maze-solver--bonus-
# maze.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'point'

class Maze
    DIRECTIONS = [[1,1], [1,0], [0,1], [-1,0], [0, -1], [-1, -1]]
    attr_reader :maze, :grid

    def initialize
        @grid = read_grid("./static/maze1.txt")
        @maze = create_maze(@grid)
        @bounds = get_bounds
    end

    def print_maze
        # cur_x = 0
        # @maze.each do |point|
        #     if point.x > cur_x
        #         cur_x = point.x
        #         puts
        #     end
        #     point.print
        # end
        @grid.each { |line| puts line.join }
        true
    end

    def read_grid(filename)
        grid = []
        File.foreach(filename) { |line| grid << line.chomp.split("") }
        grid
    end

    def create_maze(grid)
        maze = Set.new
        grid.each_index do |y|
            grid[y].each_index { |x| maze << Point.new(x, y, grid[y][x]) }
        end
        maze
    end

    def find_start
        @maze.select { |point| point.val == 'S' }[0]
    end

    def find_end
        @maze.select { |point| point.val == 'E' }[0]
    end

    def find_point(x,y)
        @maze.select { |point| point.x == x && point.y == y }[0]
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
        x = @grid.max { |row| row.length }.length - 1
        y = @grid.length - 1
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
end
    