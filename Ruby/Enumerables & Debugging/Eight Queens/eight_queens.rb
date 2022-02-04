# Eight Queens - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/eight-queens-puzzle--bonus-
# Solution by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require ('set')

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
    # (0...8).each { |i| board[i][i] = '[Q]' }
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

def collect_squares
    squares = Set[]
    @board.each_index do |rank|
        @board[rank].each_index do |file|
            squares << [rank, file]
        end
    end
    squares
end

def get_diagonals(pos)
    DIAGONALS.select do |diag|
        diag.any? { |square| square == pos }
    end
end

def get_queen_positions
    positions = []
    @board.each_index do |rank|
        @board[rank].each_index do |file|
            positions << [rank, file] if @board[rank][file] == '[Q]'
        end
    end
    positions
end

def get_conflicts(pos)
    rank, file = *pos
    diags = get_diagonals(pos)
    queens = get_queen_positions
    conflicts = 0

    conflicts += queens.select { |queen_pos| queen_pos[0] == rank}.length
    conflicts += queens.select { |queen_pos| queen_pos[1] == file}.length
    conflicts += queens.select do |queen_pos|
        diags.any? do |diag|
            diag.any? { |square| square == queen_pos }
        end
    end.length
    conflicts
end

def make_best_move(pos)
    remove_queen(pos)
    best = SQUARES.reject { |square| square == pos }
        .min { |a, b| get_conflicts(a) <=> get_conflicts(b) }
    add_queen(best)
    nil
end

def solve
    steps = 0
    until solved? || steps == 10000 do 
        queens = get_queen_positions
        queens.each do |pos|
            make_best_move(pos)
            steps += 1
            break if solved?
        end
    end
    pretty_print
    puts "Solved in #{steps} steps." if solved?
    puts "Failed to solve. Last attempt shown." unless solved?
end

def solved?
    queens = get_queen_positions
    queens.all? { |queen| get_conflicts(queen) <= 3 }
end

def add_queen(pos)
    r, f = *pos
    @board[r][f] = "[Q]"
end

def remove_queen(pos)
    r, f = *pos
    @board[r][f] = "[ ]"
end

def pretty_print
    @board.each do |row|
        puts row.join(" ")
    end
    true
end

if __FILE__ == $PROGRAM_NAME   
    @board = place_initial_queens
    SQUARES = collect_squares
    DIAGONALS = collect_diagonals
    solve
end