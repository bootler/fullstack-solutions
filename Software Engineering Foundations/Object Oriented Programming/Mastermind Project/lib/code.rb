require "byebug"

class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  attr_reader :pegs

  def self.valid_pegs?(chars)
    chars.all? { |ch| POSSIBLE_PEGS.key?(ch.upcase) }
  end

  def initialize(chars)
    raise "There are invalid pegs!" if !Code.valid_pegs?(chars)
    @pegs = chars.map(&:upcase)
  end

  def self.random(num)
    arr = []
    (0...num).each do |i|
      arr << POSSIBLE_PEGS.keys[(rand(0...POSSIBLE_PEGS.keys.length))]
    end
    Code.new(arr)
  end

  def self.from_string(pegs)
    Code.new(pegs.split(""))
  end

  def [](idx)
    @pegs[idx]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    num = 0
    guess.pegs.each_with_index { |peg,idx| num += 1 if peg == @pegs[idx] }
    num
  end

  def num_near_matches(guess)
    num = 0
    guess.pegs.each_with_index do |peg,idx|
      if @pegs.include?(peg)
        num += 1 if @pegs[idx] != peg
      end
    end
    num
  end

  def ==(code)
    return true if code.pegs == @pegs
    return false
  end
end
