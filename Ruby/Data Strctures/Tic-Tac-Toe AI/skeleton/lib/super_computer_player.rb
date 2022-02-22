# Tic Tac Toe AI - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/tic-tac-toe-ai
# super_computer_player.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    winner = node.children.find { |kid| kid.winning_node?(mark) }
    return winner.prev_move_pos if winner
    safe_move = node.children.find { |kid| !kid.losing_node?(mark) }
    if safe_move
      safe_move.prev_move_pos
    else
      raise "Computer was forced to lose! This is an error."
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
