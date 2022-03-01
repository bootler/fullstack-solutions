# Chess (Part Three) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-three-
# display.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display
    attr_reader :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        display = generate_chessboard
        y, x = *@cursor.cursor_pos
        if @cursor.selected
            display[y][x] = display[y][x].on_green
        else
            display[y][x] = display[y][x].on_red
        end
        display.each do |row|
            row.each { |square| print square }
            puts
        end
    end

    private

    def generate_chessboard
        toggle = true # toggle for alternating square background to make a checkerboard pattern
        disp_board = @board.rows.map { |row| row.map(&:to_s) }
        disp_board.each do |row|
            row.each_index do |idx|
                if toggle
                    if idx % 2 == 0
                        row[idx] = row[idx].on_light_black
                    else
                        row[idx] = row[idx].on_magenta
                    end
                else
                    if idx % 2 == 0
                        row[idx] = row[idx].on_magenta
                    else
                        row[idx] = row[idx].on_light_black
                    end
                end
            end
            toggle = !toggle
        end
    end
end