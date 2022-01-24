# Tic Tac Toe Project - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/software-engineering-foundations/tictactoe-project
# computer_player.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class ComputerPlayer
    attr_reader :mark
    
    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position(legal_positions)
        choice = legal_positions[rand(legal_positions.length)]
        puts "Computer player " + @mark.to_s + " placed mark at: " + choice.map(&:to_s).join(" ") + "."
        choice
    end
end