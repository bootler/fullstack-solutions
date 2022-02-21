# PolyTreeNode - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/intro-data-structures--polytreenode
# 00_tree_node.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class PolyTreeNode
    attr_reader :parent, :children, :value
    
    def initialize(value)
        @parent = nil
        @value = value
        @children = []
    end

    def parent=(par)
        @parent.children.reject! { |child| child == self } if @parent
        @parent = par
        par.children << self if par
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        unless child_node && child_node.parent == self
            raise 'error: specified node is not a child of reference node'
        end
        child_node.parent = nil
    end

    def dfs(value)
        return self if self.value == value
        @children.each do |child| 
            found = child.dfs(value)
            return found if found
        end 
        nil
    end

    def bfs(value)
        queue = [self]
        until queue.empty?
            queue += queue.first.children
            found = queue.shift
            return found if found.value == value
        end
        nil
    end
end