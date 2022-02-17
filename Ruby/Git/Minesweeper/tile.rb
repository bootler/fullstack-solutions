# Minesweeper - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/minesweeper
# tile.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require 'colorize'

class Tile
    attr_reader :is_bomb, :revealed
    attr_accessor :is_cursor, :value

    def initialize
        @is_bomb = false
        @is_cursor = false
        @flagged = false
        @revealed = false
        @value=nil
    end

    def set_bomb
        @is_bomb = true
    end

    def toggle_flag
        @flagged = !@flagged
    end

    def reveal
        if @flagged
            puts "Square is flagged! Unflag first."
            puts "(press Enter to continue)"
            gets
        else
            @revealed = true
        end
        self
    end

    def to_s
        return " ".on_blue.blink if @is_cursor
        if @revealed
            return "!".black.on_red if @is_bomb
            colors = [:red, :blue, :green]
            if @value
                i = @value % colors.length
                return @value.to_s.colorize(colors[i]).colorize( :background => :white )
            else
                return " ".on_white
            end
        elsif @flagged
            return "F".red.on_black
        else
            return "+".white.on_light_black
        end
    end
end