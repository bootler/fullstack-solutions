# Sudoku - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/sudoku
# board.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'tile'

class Board
    def self.from_file(filename)
        grid = []
        File.foreach(filename) { |line| grid << line.chomp.split("") }
        grid.map do |row|
            row.map do |num|
                num = num.to_i
                if num > 0
                    Tile.new(num, true)
                else
                    Tile.new(num, false)
                end
            end
        end
    end
    
    def initialize(grid)
        @grid = grid
        @rows = populate_rows
        @cols = populate_cols
        @cells = populate_cells
    end

    def render
        (0...@grid.length).step(3) do |i|
            21.times { print "-" }
            puts
            (0...3).each do |j|
                puts format_row(i,j)
            end
        end
        nil
    end

    def solved?
        cells = @cells.map(&:flatten)
        solved_area?(@rows) && solved_area?(@cols) && solved_area?(cells)
    end

    def update_tile(row, col, val)
        @grid[row][col].value = val
    end

    private 

    def format_row(cell,cell_row)
        output = []
        (0...3).each do |i|
            output << @cells[cell + i][cell_row].join(" ")
        end
        "#{output.join(" | ")}"
    end

    def solved_area?(area)
        area = area.map { |a| a.map(&:value) }
        area.all? do |a|
            a.all? { |el| (1..9).include?(el) } && 
            a.uniq.length == a.length
        end
    end

    def populate_cells
        cells = []
        (0...@grid.length).step(3) do |i|
            (0...@grid.length).step(3) do |j|
                cell = []
                @grid[i...i+3].each do |row| 
                    cell << row[j...j+3]
                end
                cells << cell
            end
        end
        cells
    end

    def populate_cols
        cols = []
        @grid.each_index do |i|
            cols << @grid.map { |row| row[i] }
        end
        cols
    end

    def populate_rows
        rows = []
        @grid.each { |row| rows << row }
        rows
    end
end