# Maze Solver - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/maze-solver--bonus-
# maze_solver.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'maze'

class MazeSolver
    attr_reader :maze

    def initialize
        @maze = Maze.new
        start = @maze.find_start
        @end = @maze.find_end
        @open_list = [start]
        @closed_list = Set[]
    end

    def compile_path(point=@end)
        return [] if point == nil
        path = compile_path(point.parent)
        path << point
        path
    end

    def generate_path_data
        until @open_list.length == 0 || in_closed_list?(@end)
            @open_list.sort_by { |node| node.f }
            current_node = @open_list.shift
            @closed_list << current_node
            
            @maze.get_neighbours(current_node).each do |nbr|
                next if in_closed_list?(nbr)
                node_in_list = in_open_list?(nbr)
                if node_in_list
                    parent = node_in_list.parent
                    g = node_in_list.g
                    node_in_list.parent = current_node
                    if score_g(node_in_list) > g
                        node_in_list.parent = parent
                        node_in_list.g = g
                    end
                else
                    nbr.parent = current_node
                    score_f(nbr)
                    @open_list << nbr
                end
            end
        end
    end

    def in_closed_list?(point)
        @closed_list.select { |node| node == point }[0]
    end

    def in_open_list?(point)
        @open_list.select { |node| node == point }[0]
    end
    
    def score_f(point)
        point.f = score_g(point) + score_h(point)
        point.f
    end

    # the base cost of 10 for an orthogonal move is arbitrary
    # the cost of 14 for a diagonal move approximates the sqrt(2) cost
    # a diagonal move where 2 is the amount of orthoganal moves needed
    # to travel the same distance. 
    def score_g(point)
        parent = point.parent
        if point.x != parent.x && point.y != parent.y
            point.g = parent.g + 14
        else
            point.g = parent.g + 10
        end
        point.g
    end

    # manhattan method: calculate the total number of horizontal and vertical moves
    # needed to reach the end from the current point, ignoring obstacles.
    # multiplied by the base cost of such moves (10 in this case)
    def score_h(point)
        x = (@end.x - point.x).abs
        y = (@end.y - point.y).abs
        (x + y) * 10
    end

    def test
        generate_path_data
        path = compile_path
        path.each do |point|
            point.val = 'X' unless point.val == 'E' || point.val == 'S'
            @maze.update(point)
        end
        @maze.print_maze
    end
end


