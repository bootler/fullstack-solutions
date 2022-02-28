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
            if @board.checkmate?(:white)
                puts "White king now in mate"
                gets
            end
            if @board.checkmate?(:black)
                puts "Black king now in mate"
                gets
            end
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
    b = Board.new
    d = b.dup
    Display.new(d).test_play
end