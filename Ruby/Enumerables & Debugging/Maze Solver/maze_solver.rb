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
        @open_list = [[start, start]] #[point, parent]
        @closed_list = Set[]
        @end = @maze.find_end
    end

    def compile_path(node)
        point, parent = *node
        return [point] if parent == point
        path = compile_path(in_closed_list?(parent))
        path << point
        path
    end

    def generate_path
        until @open_list.length == 0 || @closed_list.member?(@end)
            @open_list.sort_by { |node| node[0].f }
            current_node = @open_list.shift
            @closed_list << current_node
            current_point = current_node[0]
            
            @maze.get_neighbours(current_point).each do |nbr|
                next if in_closed_list?(nbr)
                node_in_list = in_open_list?(nbr)
                node = [nbr, current_point]
                if node_in_list
                    node_in_list = compare_g(node_in_list, node)
                else
                    score_f(node)
                    @open_list << node
                end
            end
        end
    end

    def in_closed_list?(point)
        @closed_list.select { |node| node[0] == point }[0]
    end

    def in_open_list?(point)
        @open_list.select { |node| node[0] == point }[0]
    end
    
    # a node is an array containing two Points in the form [point, parent]
    def score_f(node)
        point, parent = *node
        point.f = score_g(node) + score_h(point)
        point.f
    end

    # the base cost of 10 for an orthogonal move is arbitrary
    # the cost of 14 for a diagonal move approximates the sqrt(2) cost
    # a diagonal move where 2 is the amount of orthoganal moves needed
    # to travel the same distance. 
    def score_g(node)
        point, parent = *node
        if point.x != parent.x && point.y != parent.y
            point.g = parent.g + 14
        else
            point.g = parent.g + 10
        end
        point.g
    end

    def compare_g(node1, node2)
        old_g = node1[0].g
        new_g = score_g(node2)
        return node2 if new_g < old_g
        node1[0].g = old_g
        node1
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
        generate_path
        end_node = in_closed_list?(@end)
        path = compile_path(end_node)
        path.each do |point|
            point.val = 'X' unless point.val == 'E' || point.val == 'S'
            @maze.update(point)
        end
        @maze.print_maze
    end
end


