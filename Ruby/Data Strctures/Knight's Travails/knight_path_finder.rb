# Knight's Travails - From App Academy Open Full Stack Course
# Note: This class implements all requirements from both parts 1 & 2
# https://open.appacademy.io/learn/full-stack-online/ruby/knights-travails
# https://open.appacademy.io/learn/full-stack-online/ruby/knights-travails--part-2
# knight_path_finder.rb by: Alex Boutilier
#
# The PolyTreeNode class required from this solution was created
# from an earlier exercise (link in the source file provided).
# 
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'helpers/poly_tree_node'

class KnightPathFinder
    def self.valid_moves(pos)
        x, y = *pos
        moves = [[x + 1, y - 2], 
            [x + 2, y - 1], 
            [x + 2, y + 1], 
            [x + 1, y + 2],
            [x - 1, y + 2],
            [x - 2, y + 1],
            [x - 2, y - 1],
            [x - 1, y - 2]]
        moves.reject do |move|
            x, y = *move
            x < 0 || x > 7 || y < 0 || y > 7
        end
    end

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
    end

    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos).reject { |move| @considered_positions.include?(move) }
        @considered_positions += moves
        moves
    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty?
            cur_node = queue.shift
            moves = new_move_positions(cur_node.value)
            moves.each do |move|
                node = PolyTreeNode.new(move)
                cur_node.add_child(node)
                queue.push(node)
            end
        end
    end

    def find_path(end_pos)
        end_node = @root_node.dfs(end_pos)
        trace_path_back(end_node).reverse.map(&:value)
    end

    def trace_path_back(node)
        return [] unless node
        path = [node]
        path += trace_path_back(node.parent)
        path
    end
end

if __FILE__ == $PROGRAM_NAME
    kpf = KnightPathFinder.new([0, 0])
    kpf.build_move_tree
    p kpf.find_path([7, 6])
    p kpf.find_path([6, 2])
end