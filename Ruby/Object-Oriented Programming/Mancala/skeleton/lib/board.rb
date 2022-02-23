# Mancala - From App Academy Open Full Stack Course
# https://open.appacademy.io/learn/full-stack-online/ruby/mancala
# board.rb by: Alex Boutilier
#
# Part of 'bootler/fullstack-solutions' repository
# https://github.com/bootler/fullstack-solutions
class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14) { Array.new }
    @name1 = name1
    @name2 = name2
    place_stones
  end

  def place_stones
    (0...@cups.length).each do |i|
      next if i == 6 || i == 13
      cups[i] = [:stone, :stone, :stone, :stone]
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos < 0 || start_pos >= @cups.length
    raise "Starting cup is empty"if @cups[start_pos].empty?
    true
  end

  def make_move(start_pos, current_player_name)
    i = 0
    cur_cup = i
    score_cup = 6
    opp_score_cup = 13
    if current_player_name == @name2
      score_cup = 13
      opp_score_cup = 6
    end
    until @cups[start_pos].empty?
      i += 1
      cur_cup = (start_pos + i) % 14
      @cups[cur_cup].push @cups[start_pos].shift unless cur_cup == opp_score_cup
    end
    render
    next_turn(cur_cup, score_cup)
  end

  def next_turn(ending_cup_idx, score_cup)
    return :prompt if ending_cup_idx == score_cup
    return :switch if @cups[ending_cup_idx].length == 1
    ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all?(&:empty?) || @cups[7..12].all?(&:empty?)
  end

  def winner
    return :draw if @cups[6].length == @cups[13].length
    cups[6].length > cups[13].length ? @name1 : @name2
  end
end
