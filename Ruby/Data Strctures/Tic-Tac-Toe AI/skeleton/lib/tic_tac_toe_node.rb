require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    return true if @board.won? && @board.winner != evaluator
    if evaluator == @next_mover_mark
      children.all? { |kid| kid.losing_node?(evaluator) }
    else
      children.any? { |kid| kid.losing_node?(evaluator)}
    end
  end

  def winning_node?(evaluator)
    return @board.winner == evaluator if @board.over?
    if evaluator == @next_mover_mark
      children.any? { |kid| kid.winning_node?(evaluator) }
    else
      children.all? { |kid| kid.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    @board.rows.each.with_index do |row, i|
      row.each_index do |j|
        if @board.empty?([i,j])
          b = @board.dup
          b[[i, j]] = @next_mover_mark
          children << TicTacToeNode.new(b, get_next_mark(@next_mover_mark), [i, j])
        end
      end
    end
    children
  end

  def get_next_mark(mark)
    mark == :x ? :o : :x
  end
end
