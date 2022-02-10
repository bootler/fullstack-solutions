# Sudoku - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/sudoku
# tile.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'board'

class Solver
    attr_reader :board

    def initialize(filename)
        @board = Board.from_file(filename)
        @cells = @board.cells.map(&:flatten)
        @empty_tiles = get_empty_tiles
    end

    def solve
        solve_recursively(0)
        refresh
        puts "Solution found."
    end

    def solve_recursively(i)
        return if @board.solved?
        refresh
        pos = @empty_tiles[i]
        if increment(*pos) > 9
            solve_recursively(i - 1)
            return
        end
        while violation?(pos)
            if increment(*pos) > 9
                solve_recursively(i - 1)
                return
            end
        end
        solve_recursively(i + 1)
    end

    def refresh
        system("clear")
        @board.render
    end

    def increment(row, col)
        val = @board.grid[row][col].value + 1
        if val <= 9
            @board.update_tile(row, col, val) 
        else
            @board.update_tile(row, col, 0)
        end
        val
    end

    private

    def get_empty_tiles
        empty_tiles = []
        @board.grid.each_index do |row|
            @board.grid[row].each_index do |col|
                empty_tiles << [row, col] if @board.grid[row][col].value == 0
            end
        end
        empty_tiles
    end

    def violation?(pos)
        row, col = *pos
        value = @board.grid[row][col].value
        checked_area = get_row(pos) + get_col(pos) + get_cell(pos)
        checked_area.map(&:value).include?(value)
    end

    def get_row(pos)
        row, col = *pos
        found = @board.rows.select { |r| r.include?(@board.grid[row][col]) }[0]
        found.reject { |tile| tile == @board.grid[row][col] }
    end

    def get_col(pos)
        row, col = *pos
        found = @board.cols.select { |c| c.include?(@board.grid[row][col]) }[0]
        found.reject { |tile| tile == @board.grid[row][col] }
    end

    def get_cell(pos)
        row, col = *pos
        found = @cells.select { |cell| cell.include?(@board.grid[row][col]) }[0]
        found.reject { |tile| tile == @board.grid[row][col] }
    end
end

if __FILE__ == $PROGRAM_NAME
    Solver.new('./static/sudoku1.txt').solve
end

