# Tic Tac Toe Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/tictactoe-project
# board.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Board
    def initialize(size)
        @grid = Array.new(size) { Array. new(size, '_') }
    end

    def valid?(position)
        return false if position.any? { |i| i < 0 } # disallow RTL index reference
        row, col = position
        return false if @grid[row] == nil 
        @grid[row][col] != nil
    end

    def empty?(position)
        row, col = position
        return false if !self.valid?(position)
        @grid[row][col] == '_'
    end

    def place_mark(position, mark)
        row, col = position
        if self.empty?(position)
            @grid[row][col] = mark
            return true
        else
            return false
        end
    end

    def print
        @grid.each { |row| p row }
    end

    def win_row?(mark)
        @grid.any? { |row| row.all? { |square| square == mark } }
    end

    def win_col?(mark)
        (0...@grid[0].length).each do |col|
            return true if @grid.all? { |row| row[col] == mark }
        end
        false
    end

    def win_diagonal?(mark)
        last_row = @grid.length - 1
        descending = @grid[0][0] == mark
        ascending = @grid[last_row][0] == mark
        return false if !descending && !ascending
        (0...last_row).each do |idx|
            if descending
                cur_desc = @grid[idx][idx]              # current descending diagonal square
                next_desc = @grid[idx + 1][idx + 1]
                return false if next_desc != cur_desc
            end
            if ascending
                cur_asc = @grid[last_row - idx][idx]    # current ascending diagonal square
                next_asc = @grid[last_row - idx - 1][idx + 1]
                return false if next_asc != cur_asc
            end
        end
        true
    end

    def win?(mark)
        self.win_row?(mark) || self.win_col?(mark) || self.win_diagonal?(mark)
    end

    def empty_positions?
        @grid.any? { |row| row.any? { |square| square == "_" } }
    end

    def legal_positions
        legal_positions = []
        @grid.each_index do |i|
            @grid[i].each_index do |j|
                legal_positions << [i, j] if self.empty?([i, j])
            end
        end
        legal_positions
    end
end