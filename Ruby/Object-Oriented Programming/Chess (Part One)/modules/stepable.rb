# Chess (Part One) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-one-
# stepable.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
module Stepable
    def moves
        moves = []
        move_diffs.each do |diff|
            dy, dx = *diff
            y, x = *pos
            move = [y + dy, x + dx]
            next unless board.valid_square?(move)
            moves << move if board.empty?(move) || board[move].color != self.color
        end
        moves
    end

    def move_diffs
    end
end