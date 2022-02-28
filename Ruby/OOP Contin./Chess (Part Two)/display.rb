# Chess (Part Two) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-two-
# display.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require 'colorize'
require_relative 'board'
require_relative 'cursor'

class Display
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
    end

    def render
        system("clear")
        display = assign_checkerboard_pattern
        y, x = *@cursor.cursor_pos
        if @cursor.selected
            display[y][x] = display[y][x].on_green
        else
            display[y][x] = display[y][x].on_red
        end
        display.each do |row|
            row.each { |sq| print sq }
            puts
        end
    end

    def test_play #debug only, will be removed
        s_p = []
        loop do
            render
            c = @cursor.get_input
            if c
                if @cursor.selected
                    s_p = c
                else
                    @board.move_piece(@board[s_p].color, s_p, c)
                    s_p = []
                end
            end
            if @board.in_check?(:white)
                puts "White king now in check"
                gets
            end
            if @board.in_check?(:black)
                puts "Black king now in check"
                gets
            end
        end
    end

    private

    def assign_checkerboard_pattern
        toggle = true # toggle for alternating square background to make a checkerboard pattern
        disp_board = @board.rows.map { |row| row.map(&:to_s) }
        disp_board.each do |row|
            row.each_index do |idx|
                if toggle
                    if idx % 2 == 0
                        row[idx] = row[idx].on_light_cyan
                    else
                        row[idx] = row[idx].on_blue
                    end
                else
                    if idx % 2 == 0
                        row[idx] = row[idx].on_blue
                    else
                        row[idx] = row[idx].on_light_cyan
                    end
                end
            end
            toggle = !toggle
        end
    end
end

# debug only, will be removed
if __FILE__ == $PROGRAM_NAME
    Display.new(Board.new).test_play
end