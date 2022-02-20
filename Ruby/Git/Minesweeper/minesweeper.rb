# Minesweeper - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/minesweeper
# minesweeper.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require 'remedy'
require 'yaml'
require_relative 'board'

class Minesweeper
    include Remedy
    attr_reader :board
    INPUT = Interaction.new
    START_TIME = Time.now
    
    def initialize
        @board = Board.new(9)
        @cursor_pos = [0, 0]
    end

    def play
        setup
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
            when "s"
                save
                puts "Saved successfully!"
                sleep(0.5)
            when "q"
                system("clear")
                ANSI.cursor.show!
                exit
            else
                puts "Command not recognized: #{key.to_s}"
            end
            @board.render
            break if @board.won? || @board.lost?
        end
        if @board.lost?
            @board.reveal_bombs
            @board.render
            puts "Sorry, you lost!"
        else
            puts "Congrats, you have won in: #{Integer(Time.now - START_TIME)} seconds"
        end
        ANSI.cursor.show!
    end

    def move(direction)
        cursor = @board.cursor_pos.dup
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

    def setup
        @board.update_cursor(@cursor_pos)
        @board.render
    end

    def save
        n = Dir.entries('saved_games').length - 1
        f = File.open("saved_games/save#{n}.yml","w+")
        f.write(self.to_yaml)
    end
end

if __FILE__ == $PROGRAM_NAME
    if ARGV[0]
        begin
            m = YAML.load_file(ARGV[0])
        rescue
            puts "File not found! Launching new game.".red
            sleep(1.25)
            m = Minesweeper.new
        end
    else
        m = Minesweeper.new
    end
    m.play
end
