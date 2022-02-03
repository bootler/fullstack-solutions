# Eight Queens - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/eight-queens-puzzle--bonus-
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions

# "p_rd" where p => plane => [r, f, d] => rank,file,diagonal
# rd => relative direction => [fw, bk] => forward, backward
# e.g. "r_fw" = forward along the specified rank 
# DIRECTIONS = ["r_fw", "r_bk", "f_fw", "f_bk", "d_fw", "d_bk"]

# generate an initial placement for the queens that approimates a solution as closely
# as possible in a single step.
#
# This placement uses alternating knight-moves for the initial placement.
# On any n*n chessboard where n > 3 and n % 2 == 1 (odd), this provides a complete solution.
# On any n*n chessboard where n > 4 and n % 2 == 0 (even), we add an offset of 1 rank
# for every n / 2 knight moves to prevent the pattern from repeating. 
# This reduces queen conflicts to those on the long diagonal 
# e.g. (file, rank): (1, n) > (n, 1) of any such chessboard.
def place_initial_queens
    board = Array.new(8) { Array.new(8, '[ ]') }
    rank = 0
    count_4 = 0 
    board.each_index do |file|
        board[rank][file] = '[Q]'
        rank = (rank + 2) % 8
        count_4 += 1
        rank += 1 if count_4 % 4 == 0
    end
    board
end

def collect_diagonals
    diagonals = Set[]
    bound = @board.length - 1
    @board.each_index do |rank|
        d1 = Set[]
        d2 = Set[]
        d3 = Set[]
        d4 = Set[]
        (rank..bound).each do |i|
            d1 << [rank + (i - rank), i - rank]
            d2 << [i - rank, rank + (i - rank)]
            d3 << [bound - (rank + (i - rank)), i - rank]
            d4 << [bound - (i - rank), rank + (i - rank)]
        end
        diagonals << d1 << d2 << d3 << d4
    end
    diagonals
end


def get_queen_positions
    positions = []
    @boad.each_index do |rank|
        @board[rank].each_index do |file|
            positions << [rank, file] if @board[rank][file] == '[Q]'
        end
    end
    positions
end

# def get_legal_moves(pos)
#     rank, file = *pos
#     bound = @board.length #square board, so board.length == board[0..-1].length
#     moves = Set[]
#     DIRECTIONS.each |dir|
#         case dir
#         when "r_fw"
#             (file + 1...bound).each { |file| moves << [rank, file] }
#         when "r_bk"
#             (file - 1).downto(0).each { |file| moves << [rank, file] }
#         when "f_fw"
#             (rank + 1...bound).each { |rank| moves << [rank, file] }
#         when "f_bk"
#             (rank - 1).downto(0).each { |rank| moves << [rank, file] }
#         when "d_fw"
#         else
#         end


def pretty_print
    @board.each do |row|
        puts row.join(" ")
    end
    true
end

def test
    @board.map! { |row| row.map { |el| el = "[ ]"} }
    diags = collect_diagonals
    diags.each do |diag|    
        diag.each do |pos|
            r, f = *pos
            @board[r][f] = '[X]'
        end
    end
    pretty_print
    true
end

@board = place_initial_queens