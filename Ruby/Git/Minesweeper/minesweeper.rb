# Minesweeper - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/minesweeper
# minesweeper.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require 'remedy'
require_relative 'board'

class Minesweeper
    include Remedy
    INPUT = Interaction.new
    
    def initialize
        @board = Board.new(9)
        @cursor_pos = [0, 0]
    end

    def play
        @board.update_cursor(@cursor_pos)
        @board.render
        INPUT.loop do |key|
            case key.to_s
            when "left"
                move(:left)
            when "right"
                move(:right)
            when "up"
                move(:up)
            when "down"
                move(:down)
            when "f"
                flag(@cursor_pos)
            when "control_m" # enter key
                reveal(@cursor_pos)
            when "q"
                INPUT.quit!
            else
                puts "Command not recognized: #{key.to_s}"
                gets
            end
            @board.render
            break if @board.won? || @board.lost?
        end
        @board.reveal_bombs if @board.lost?
        @board.render
        ANSI.cursor.show!
    end

    def move(direction)
        cursor = @board.cursor_pos.map { |item| item }
        case direction
        when :left
            cursor[0] -= 1
        when :right
            cursor[0] += 1
        when :up
            cursor[1] -= 1
        when :down
            cursor[1] += 1
        else
        end
        @board.update_cursor(cursor)
        @cursor_pos = @board.cursor_pos
    end

    def flag(pos)
        @board.flag
    end

    def reveal(pos)
        @board.reveal(pos)
    end
end

if __FILE__ == $PROGRAM_NAME
    m = Minesweeper.new
    m.play
end
