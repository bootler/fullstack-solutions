# Chess (Part Two) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-two-
# pawn.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'piece'

class Pawn < Piece
    def symbol
        '♟'
    end

    def moves
        moves = forward_steps + side_attacks
        moves.select { |move| board.valid_square?(move) }
    end

    private

    def at_start_row?
        self.color == :white ? start_y = 6 : start_y = 1
        pos[0] == start_y
    end

    def forward_dir
        self.color == :white ? -1 : 1
    end
    
    def forward_steps
        y, x = *pos
        steps = []
        steps << [y + forward_dir, x]
        steps << [y + (forward_dir * 2), x] if at_start_row?
        steps
    end

    def side_attacks
        y, x = *pos
        threats = [[y + forward_dir, x + 1], [y + forward_dir, x - 1]]
        threats.select do |threat|
            board.valid_square?(threat) &&
            !board[threat].empty? &&
            board[threat].color != self.color
        end
    end
end