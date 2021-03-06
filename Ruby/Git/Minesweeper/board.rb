# Minesweeper - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/minesweeper
# board.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'tile'
require 'remedy'

class Board
    include Remedy
    attr_reader :cursor_pos
    SCREEN = Viewport.new
    HEADER = Header.new(["Welcome to Minesweeper!",
    "Use arrow keys to select a tile",
    "Press F to flag/unflag a tile, or Enter to reveal it.",
    "Press S to save the game",
    "Press Q to quit."])
    
    def initialize(size)
        @size = size
        @grid = create_grid(size)
        seed_bombs(@grid, @size)
        @cursor_pos = [0, 0]
    end

    def create_grid(size)
        grid = Array.new(size) { Array.new(size, nil)}
        grid.map! do |row|
            row.map! { |tile| tile = Tile.new }
        end
        grid
    end

    def flag
        x, y = *@cursor_pos
        @grid[y][x].toggle_flag
    end

    def reveal(pos)
        x, y = *pos
        tile = @grid[y][x].reveal
        return if tile.is_bomb
        nbrs = get_neighbors(pos)
        if check_neighbors(nbrs)
            nbrs.each do |nbr|
                x, y = *nbr
                nbr_tile = @grid[y][x]
                reveal(nbr) unless nbr_tile.revealed
            end
            return
        end
        count = count_nbr_bombs(nbrs)
        tile.value = count if count > 0
    end

    def reveal_bombs
        remove_cursor
        @grid.each do |row|
            row.each { |tile| tile.reveal if tile.is_bomb }
        end
    end

    def update_cursor(pos)
        return if pos.any? { |axis| axis < 0 || axis >= @size }
        remove_cursor
        @cursor_pos = pos
        add_cursor
    end

    def render
        SCREEN.draw(HEADER)
        puts
        @grid.each { |row| puts "    #{row.join("")}" }
    end

    def won?
        @grid.all? do |row|
            row.all? { |tile| tile.revealed || tile.is_bomb }
        end
    end

    def lost?
        @grid.any? do |row|
            row.any? { |tile| tile.is_bomb && tile.revealed }
        end
    end

    private

    def check_neighbors(nbrs)
        nbrs.map do |nbr|
            x, y = *nbr
            @grid[y][x]
        end.none? { |tile| tile.is_bomb }
    end

    def count_nbr_bombs(nbrs)
        count = 0
        nbrs.each do |nbr|
            x, y = *nbr
            nbr_tile = @grid[y][x]
            count += 1 if nbr_tile.is_bomb
        end
        count
    end


    def get_neighbors(pos)
        x, y = *pos
        nbrs = [[x - 1, y], [x + 1, y], [x, y - 1], 
        [x, y + 1], [x + 1, y + 1], [x - 1, y - 1],
        [x + 1, y - 1], [x - 1, y + 1]]
        nbrs.reject do |pos|
            p_x, p_y = *pos
            p_x < 0 || p_x >= @size || p_y < 0 || p_y >= @size
        end
    end

    def add_cursor
        x, y = *@cursor_pos
        @grid[y][x].is_cursor = true
    end

    def remove_cursor
        x, y = *@cursor_pos
        @grid[y][x].is_cursor = false
    end

    def seed_bombs(grid, size)
        count_bombs = 0
        until count_bombs == size
            bomb_tile = grid[rand(size)][rand(size)]
            unless bomb_tile.is_bomb
                bomb_tile.set_bomb
                count_bombs += 1
            end
        end
    end

end
