# Battleship Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/battleship-project
# board.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require "byebug"

class Board
    attr_reader :size
  
    def initialize(n)
        @grid = Array.new(n) { Array.new(n,:N) }
        @size = n * n
    end

    def [](pos)
        @grid[pos[0]][pos[1]]
    end

    def []=(pos,val)
        @grid[pos[0]][pos[1]] = val
    end

    def num_ships
        count = 0
        @grid.each { |row| count += row.count(:S) }
        count
    end

    def attack(pos)
        if self[pos] == :S
            self[pos] = :H
            puts "You sunk my battleship!"
            return true
        else
            self[pos] = :X
            return false
        end
    end

    def place_random_ships
        cap = (@size * 0.25).truncate
        ctr = 0
        while ctr < cap do
            pos = [rand(0...@grid.length), rand(0...@grid.length)]
            if self[pos] != :S
                self[pos] = :S
                ctr += 1
            end
        end
    end

    def hidden_ships_grid
        @grid.map do |row| 
            row.map do |col| 
                col = :N if col == :S
                col
            end
        end
    end

    def self.print_grid(grid)
        grid.each do |row|
           puts row.join(" ")
        end
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print
        Board.print_grid(hidden_ships_grid)
    end
end
