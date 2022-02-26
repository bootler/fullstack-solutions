# Chess (Part One) - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/chess--part-one-
# slideable.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
module Slideable
    ORTHOGANAL_DIRS = [[-1, 0],[1, 0],[0, -1], [0, 1]]
    DIAGONAL_DIRS = [[-1, -1], [1, 1], [-1, 1], [1, -1]]

    def orthoganal_dirs
        ORTHOGANAL_DIRS
    end

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def moves
        moves = []
        move_dirs.each do |dir|
            moves += grow_unblocked_moves_in_dir(*dir)
        end
        moves
    end

    private

    def move_dirs
    end

    def grow_unblocked_moves_in_dir(dy, dx)
        moves = []
        y, x = *pos
        loop do
            y += dy
            x += dx
            move = [y, x]
            print move
            gets
            break unless board.valid_square?(move)
            if board[move].empty?
                moves << move
            else
                moves << move if board[move].color != self.color
                break 
            end
        end
        moves
    end
end